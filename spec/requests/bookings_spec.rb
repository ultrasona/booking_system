# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bookings', type: :request do
  describe 'POST /rooms/:room_id/bookings' do
    let(:user) { create(:user) }
    let(:room) { create(:room) }

    context 'when the room is available' do
      it 'creates a booking' do
        post "/rooms/#{room.id}/bookings", params: {
          booking: {
            start_at: 2.days.from_now.change(hour: 9),
            end_at: 2.days.from_now.change(hour: 11)
          },
          user_id: user.id
        }, as: :json

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('id')
      end
    end

    context 'when the room is not available' do
      before do
        create(:booking, room: room, start_at: 2.days.from_now.change(hour: 9),
                         end_at: 2.days.from_now.change(hour: 11), user: user)
      end

      it 'returns an error' do
        post "/rooms/#{room.id}/bookings", params: {
          booking: {
            start_at: 2.days.from_now.change(hour: 10),
            end_at: 2.days.from_now.change(hour: 12)
          },
          user_id: user.id
        }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['error']).to eq('La salle est déjà réservée sur ce créneau')
      end
    end
  end
end
