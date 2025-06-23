# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# --- Users ---
users = User.create!([
                       { email: 'alice.dupont@example.com', name: 'Alice Dupont' },
                       { email: 'bruno.martin@example.com', name: 'Bruno Martin' },
                       { email: 'carole.lefebvre@example.com', name: 'Carole Lefebvre' },
                       { email: 'david.moreau@example.com', name: 'David Moreau' },
                       { email: 'emma.bernard@example.com', name: 'Emma Bernard' }
                     ])

# --- Rooms ---
rooms = Room.create!([
                       { name: 'Salle Eiffel', capacity: 10 },
                       { name: 'Salle Lumière', capacity: 5 },
                       { name: 'Salle Molière', capacity: 20 },
                       { name: 'Salle Voltaire', capacity: 8 },
                       { name: 'Salle Pasteur', capacity: 12 }
                     ])

# --- Equipment ---
equipment_list = Equipment.create!([
                                     { name: 'Projecteur' },
                                     { name: 'Tableau blanc' },
                                     { name: 'Télévision' },
                                     { name: 'Téléconférence' },
                                     { name: 'Climatisation' }
                                   ])

# --- RoomsEquipment ---
# Associe des équipements aux salles de façon variée
rooms[0].equipments << equipment_list[0] << equipment_list[1] # Eiffel: projecteur + tableau
rooms[1].equipments << equipment_list[1] # Lumière: tableau
rooms[2].equipments << equipment_list[0] << equipment_list[2] << equipment_list[4] # Molière: projecteur + TV + clim
rooms[3].equipments << equipment_list[3] # Voltaire: téléconférence
rooms[4].equipments << equipment_list[0] << equipment_list[1] << equipment_list[3] # Pasteur: projecteur + tableau + téléconférence

# --- Bookings ---
Booking.create!([
                  { start_at: Time.now + 1.hour, end_at: Time.now + 2.hours, user: users[0], room: rooms[0] },
                  { start_at: Time.now + 3.hours, end_at: Time.now + 4.hours, user: users[1], room: rooms[1] },
                  { start_at: Time.now + 5.hours, end_at: Time.now + 6.hours, user: users[2], room: rooms[2] },
                  { start_at: Time.now + 1.day, end_at: Time.now + 1.day + 1.hour, user: users[3], room: rooms[3] },
                  { start_at: Time.now + 1.day + 2.hours, end_at: Time.now + 1.day + 3.hours, user: users[4],
                    room: rooms[4] }
                ])
