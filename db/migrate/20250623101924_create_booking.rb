# frozen_string_literal: true

class CreateBooking < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
