# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  capacity   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
  validates :name, presence: true
  validates :capacity, presence: true

  has_and_belongs_to_many :equipments, class_name: 'Equipment', join_table: 'rooms_equipment',
                                       association_foreign_key: 'equipment_id'

  scope :is_available, lambda { |room_id, start_at, end_at|
    where(id: room_id).where.not(
      id: Booking.where(room_id: room_id)
              .where('(start_at, end_at) OVERLAPS (?, ?)', start_at, end_at)
              .select(:room_id)
    )
  }
end
