# frozen_string_literal: true

module Users
  class BookingsController < ApplicationController
    def index
      user = User.find(params[:user_id])

      bookings = user.bookings
                     .where('start_at > ?', Time.current)
                     .order(:start_at)

      render json: bookings
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Utilisateur non trouvé' }, status: :not_found
    end
  end
end
