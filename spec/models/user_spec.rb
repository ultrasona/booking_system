# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'Jean Dupont', email: 'jean.dupont@example.com') }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
