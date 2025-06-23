# frozen_string_literal: true

class Equipment < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :rooms, class_name: 'Room', join_table: 'rooms_equipment', association_foreign_key: 'room_id'
end
