# frozen_string_literal: true

class Room < ApplicationRecord
  validates :name, presence: true
  validates :capacity, presence: true

  has_and_belongs_to_many :equipments, class_name: 'Equipment', join_table: 'rooms_equipment',
                                       association_foreign_key: 'equipment_id'
end
