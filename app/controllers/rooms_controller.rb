# frozen_string_literal: true

class RoomsController < ApplicationController
  def available
    start_at = available_params[:start_at]
    end_at = available_params[:end_at]
    equipment_ids = available_params[:equipment_ids]&.map(&:to_i) || []

    if start_at.blank? || end_at.blank?
      render json: { error: 'start_at et end_at sont requis' }, status: :unprocessable_entity
      return
    end

    available_rooms = Room
                      .available_on(start_at, end_at)
                      .with_equipments(equipment_ids)

    render json: available_rooms
  end

  private

  def available_params
    params.permit(:start_at, :end_at, :equipment_ids)
  end
end
