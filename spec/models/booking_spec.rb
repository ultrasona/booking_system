# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id         :bigint           not null, primary key
#  start_at   :datetime         not null
#  end_at     :datetime         not null
#  user_id    :bigint           not null
#  room_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Booking, type: :model do
  subject do
    user = User.new(name: 'Test', email: 'test@example.com')
    room = Room.new(name: 'Salle Test', capacity: 5)
    described_class.new(
      start_at: Time.now,
      end_at: Time.now + 1.hour,
      user: user,
      room: room
    )
  end

  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:room) }

  it { should belong_to(:user) }
  it { should belong_to(:room) }
end
