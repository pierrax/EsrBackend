require 'rails_helper'

RSpec.describe Api::CategoryCodesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all category codes' do
      create(:category_code)
      create(:category_code)

      get 'api/category_codes', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    it 'creates a category code' do
      params = { 'category_code': {
          'title': 'GRID'
        }
      }

      post 'api/category_codes', params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(CategoryCode.count).to eq(1)
    end
  end

  describe '#update' do
    it 'updates a category code' do
      c = create(:category_code)
      params = { 'category_code': {
          'title': 'GRID'
      }
      }

      put "api/category_codes/#{c.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(CategoryCode.last.title).to eq('GRID')
    end
  end

  describe '#delete' do
    it 'deletes a category code' do
      c = create(:category_code)
      delete "api/category_codes/#{c.id}"
      expect(last_response.status).to eq(200)
      expect(CategoryCode.count).to eq(0)
    end
  end
end
