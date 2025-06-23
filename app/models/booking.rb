# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id         :bigint           not null, primary key
#  start_at   :datetime         not null
#  end_at     :datetime         not null
#  user_id    :bigint           not null
#  room_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Booking < ApplicationRecord
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :user, presence: true
  validates :room, presence: true

  belongs_to :user
  belongs_to :room
end
