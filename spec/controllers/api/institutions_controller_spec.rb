require 'rails_helper'

RSpec.describe Api::InstitutionsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all institutions' do
      i1 = create(:institution)
      i2 = create(:institution)

      get 'api/institutions', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    it 'creates an institution' do
      params = { 'institution': {
          'date_start': Date.current,
        }
      }

      post 'api/institutions', params.merge(format: 'json')
      expect(last_response.status).to eq(200)
    end
  end

  describe '#update' do
    it 'updates an institution' do
      i = create(:institution)
      params = { 'institution': {
          'id': i.id,
          'date_start': Date.current - 2.days,
        }
      }

      put "api/institutions/#{i.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(Institution.last.date_start).to eq(Date.current - 2.days)
    end
  end

  describe '#delete' do
    it 'deletes an institution' do
      i = create(:institution)
      delete "api/institutions/#{i.id}"
      expect(last_response.status).to eq(200)
      expect(Institution.count).to eq(0)
    end
  end
end
