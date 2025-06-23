# frozen_string_literal: true

# == Schema Information
#
# Table name: equipment
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Equipment < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :rooms, class_name: 'Room', join_table: 'rooms_equipment', association_foreign_key: 'room_id'
end
