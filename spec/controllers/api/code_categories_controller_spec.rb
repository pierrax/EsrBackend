require 'rails_helper'

RSpec.describe Api::CodeCategoriesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all category codes' do
      create(:code_category)
      create(:code_category)

      get 'api/code_categories', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    context 'when params are valid' do
      it 'creates a code category' do
        params = {
          code_category: {
            title: 'GRID',
            position: 10
          }
        }

        post 'api/code_categories', params.merge(format: 'json')
        expect(last_response.status).to eq(200)
        expect(CodeCategory.count).to eq(1)
        expect(CodeCategory.last.position).to eq(10)
      end
    end

    context 'when params are not valid' do
      it 'returns an error' do
        params = {
          code_category: {
            title: ''
          }
        }

        post 'api/code_categories', params.merge(format: 'json')
        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Title can't be blank")
      end
    end
  end

  describe '#update' do
    it 'updates a code category' do
      c = create(:code_category)
      params = {
        code_category: {
          title: 'GRID',
          position: 5
        }
      }

      put "api/code_categories/#{c.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(CodeCategory.last.title).to eq('GRID')
      expect(CodeCategory.last.position).to eq(5)
    end
  end

  describe '#delete' do
    it 'deletes a code category' do
      c = create(:code_category)
      delete "api/code_categories/#{c.id}"
      expect(last_response.status).to eq(200)
      expect(CodeCategory.count).to eq(0)
    end
  end
end
