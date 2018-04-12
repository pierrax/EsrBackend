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
    it 'creates a code category' do
      params = {
        code_category: {
          title: 'GRID'
        }
      }

      post 'api/code_categories', params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(CodeCategory.count).to eq(1)
    end
  end

  describe '#update' do
    it 'updates a code category' do
      c = create(:code_category)
      params = {
        code_category: {
          title: 'GRID'
        }
      }

      put "api/code_categories/#{c.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(CodeCategory.last.title).to eq('GRID')
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
