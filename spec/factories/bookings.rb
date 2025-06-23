# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    start_at { 1.day.from_now.change(hour: 10) }
    end_at { 1.day.from_now.change(hour: 12) }
    user
    room
  end
end
