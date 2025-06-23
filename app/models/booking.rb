# frozen_string_literal: true

class Booking < ApplicationRecord
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :user, presence: true
  validates :room, presence: true

  belongs_to :user
  belongs_to :room
end
