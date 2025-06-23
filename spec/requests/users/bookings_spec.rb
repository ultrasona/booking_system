# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Bookings API', type: :request do
  describe 'GET /users/:user_id/bookings' do
    let(:user) { create(:user) }
    let(:room) { create(:room) }

    let!(:past_booking) do
      create(:booking, user: user, room: room, start_at: 2.days.ago, end_at: 2.days.ago + 1.hour)
    end
    let!(:future_booking1) do
      create(:booking, user: user, room: room, start_at: 1.day.from_now, end_at: 1.day.from_now + 1.hour)
    end
    let!(:future_booking2) do
      create(:booking, user: user, room: room, start_at: 3.days.from_now, end_at: 3.days.from_now + 1.hour)
    end

    it 'returns future bookings for the user' do
      get "/users/#{user.id}/bookings"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json.size).to eq(2)

      returned_ids = json.map { |b| b['id'] }
      expect(returned_ids).to match_array([future_booking1.id, future_booking2.id])
    end

    it 'returns empty array if no future bookings' do
      other_user = create(:user)
      get "/users/#{other_user.id}/bookings"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to eq([])
    end

    it 'returns 404 if user does not exist' do
      get '/users/999999/bookings'

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Utilisateur non trouvé')
    end
  end
end
