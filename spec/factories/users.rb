# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Jean Dupont' }
    sequence(:email) { |n| "jean.dupont#{n}@example.com" }
  end
end
