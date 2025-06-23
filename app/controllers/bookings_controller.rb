# frozen_string_literal: true

class BookingsController < ApplicationController
  def create
    room = Room.find(params[:room_id])

    available = Room.is_available(room.id, booking_params[:start_at], booking_params[:end_at]).exists?

    unless available
      render json: { error: 'La salle est déjà réservée sur ce créneau' }, status: :unprocessable_entity
      return
    end

    booking = Booking.new(booking_params.merge(room: room, user_id: params[:user_id]))

    if booking.save
      render json: booking, status: :created
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :user_id)
  end
end
