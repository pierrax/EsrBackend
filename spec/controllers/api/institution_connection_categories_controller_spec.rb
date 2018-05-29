require 'rails_helper'

RSpec.describe Api::InstitutionConnectionCategoriesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create' do
    context 'when params are valid' do
      it 'creates an institution connection category' do
        params = {
          institution_connection_category: {
            title: 'Département'
          }
        }

        post 'api/institution_connection_categories', params.merge(format: 'json')
        expect(last_response.status).to eq(200)
        expect(InstitutionConnectionCategory.count).to eq(1)
        expect(InstitutionConnectionCategory.first.title).to eq('Département')
      end
    end

    context 'when params are not valid' do
      it 'returns an error' do
        params = {
          institution_connection_category: {
            title: ''
          }
        }

        post 'api/institution_connection_categories', params.merge(format: 'json')
        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Title can't be blank")
      end
    end
  end

  describe '#show' do
    it 'returns all institution connection categories' do
      category = create(:institution_connection_category)
      get "api/institution_connection_categories/#{category.id}", format: :json
      expect(last_response.status).to eq(200)
    end
  end

  describe '#index' do
    it 'returns all institution connection categories' do
      create(:institution_connection_category)
      create(:institution_connection_category)

      get 'api/institution_connection_categories', format: :json

      expect(last_response.status).to eq(200)
      expect(json_response.count).to eq(2)
    end
  end

  describe '#update' do
    it 'updates an institution connection category' do
      c = create(:institution_connection_category)
      params = {
          institution_connection_category: {
              title: 'Merge'
          }
      }

      put "api/institution_connection_categories/#{c.id}", params.merge(format: 'json')

      c.reload
      expect(last_response.status).to eq(200)
      expect(c.title).to eq('Merge')
    end
  end

  describe '#delete' do
    it 'deletes an institution connection category' do
      l = create(:institution_connection_category)
      delete "api/institution_connection_categories/#{l.id}"
      expect(last_response.status).to eq(200)
      expect(InstitutionConnectionCategory.count).to eq(0)
    end
  end
end
