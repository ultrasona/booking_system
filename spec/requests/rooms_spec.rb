# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rooms::Available API', type: :request do
  describe 'GET /rooms/available' do
    let(:equipment1) { create(:equipment) }
    let(:equipment2) { create(:equipment) }

    let(:room1) { create(:room, equipments: [equipment1, equipment2]) }
    let(:room2) { create(:room, equipments: [equipment1]) }

    before do
      create(:booking, room: room1, start_at: 1.day.from_now.change(hour: 11), end_at: 1.day.from_now.change(hour: 13))
    end

    it 'returns available rooms without equipment filter' do
      get '/rooms/available', params: {
        start_at: 1.day.from_now.change(hour: 11),
        end_at: 1.day.from_now.change(hour: 13)
      }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json.map { |r| r['id'] }).to eq([room1.id])
    end

    it 'returns available rooms with equipment filter' do
      get '/rooms/available', params: {
        start_at: 1.day.from_now.change(hour: 10),
        end_at: 1.day.from_now.change(hour: 11),
        equipment_ids: [equipment1.id, equipment2.id]
      }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json.map { |r| r['id'] }).to eq([room1.id])
    end

    it 'returns error if start_at or end_at is missing' do
      get '/rooms/available', params: { start_at: 1.day.from_now.change(hour: 11) }

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('start_at et end_at sont requis')
    end
  end
end
