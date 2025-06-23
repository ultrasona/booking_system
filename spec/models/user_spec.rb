# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'Jean Dupont', email: 'jean.dupont@example.com') }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
