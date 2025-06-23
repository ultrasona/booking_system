# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  subject { described_class.new(name: 'Salle Test', capacity: 10) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:capacity) }

  it { should have_and_belong_to_many(:equipments).join_table('rooms_equipment') }
end
