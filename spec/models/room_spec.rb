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
end
