# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    name { 'Salle de réunion' }
    capacity { 10 }
  end
end
