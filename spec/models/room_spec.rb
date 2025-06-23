# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  capacity   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Room, type: :model do
  subject { described_class.new(name: 'Salle Test', capacity: 10) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:capacity) }

  it { should have_and_belong_to_many(:equipments).join_table('rooms_equipment') }

  describe '.is_available' do
    let(:room) { create(:room) }
    let(:other_room) { create(:room) }
    let(:user) { create(:user) }

    before do
      create(:booking, room: room, user: user,
                       start_at: DateTime.new.tomorrow.change(hour: 10),
                       end_at: DateTime.new.tomorrow.change(hour: 12))
    end

    it 'returns the room when there is no overlap' do
      available = Room.is_available(room.id,
                                    DateTime.new.tomorrow.change(hour: 13),
                                    DateTime.new.tomorrow.change(hour: 14))
      expect(available).to include(room)
    end

    it 'does not return the room when overlapping at start' do
      available = Room.is_available(room.id,
                                    DateTime.new.tomorrow.change(hour: 9),
                                    DateTime.new.tomorrow.change(hour: 10, min: 30))
      expect(available).to be_empty
    end

    it 'does not return the room when overlapping at end' do
      available = Room.is_available(room.id,
                                    DateTime.new.tomorrow.change(hour: 11),
                                    DateTime.new.tomorrow.change(hour: 13))
      expect(available).to be_empty
    end

    it 'does not return the room when fully inside existing booking' do
      available = Room.is_available(room.id,
                                    DateTime.new.tomorrow.change(hour: 10, min: 30),
                                    DateTime.new.tomorrow.change(hour: 11, min: 30))
      expect(available).to be_empty
    end

    it 'returns the room when completely before' do
      available = Room.is_available(room.id,
                                    DateTime.new.tomorrow.change(hour: 8),
                                    DateTime.new.tomorrow.change(hour: 9))
      expect(available).to include(room)
    end

    it 'returns the room if another room is booked at that time' do
      available = Room.is_available(other_room.id,
                                    DateTime.new.tomorrow.change(hour: 10),
                                    DateTime.new.tomorrow.change(hour: 12))
      expect(available).to include(other_room)
    end
  end
end
