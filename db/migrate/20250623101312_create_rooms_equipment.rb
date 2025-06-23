# frozen_string_literal: true

class CreateRoomsEquipment < ActiveRecord::Migration[7.1]
  def change
    create_join_table(:room, :equipment, table_name: 'rooms_equipment')
  end
end
