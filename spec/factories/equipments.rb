# frozen_string_literal: true

FactoryBot.define do
  factory :equipment do
    sequence(:name) { |n| "equipment#{n}" }
  end
end
