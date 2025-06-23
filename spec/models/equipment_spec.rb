# frozen_string_literal: true

# == Schema Information
#
# Table name: equipment
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Equipment, type: :model do
  subject { described_class.new(name: 'Projecteur') }

  it { should validate_presence_of(:name) }

  it { should have_and_belong_to_many(:rooms).join_table('rooms_equipment') }
end
