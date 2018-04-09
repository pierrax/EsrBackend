require 'rails_helper'

RSpec.describe Api::CategoryLinksController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all category links' do
      create(:category_link)
      create(:category_link)

      get 'api/category_links', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    it 'creates a category link' do
      params = { 'category_link': {
          'title': 'Facebook'
        }
      }

      post 'api/category_links', params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(CategoryLink.count).to eq(1)
    end
  end

  describe '#update' do
    it 'updates a category link' do
      c = create(:category_link)
      params = { 'category_link': {
          'title': 'Facebook'
      }
      }

      put "api/category_links/#{c.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(CategoryLink.last.title).to eq('Facebook')
    end
  end

  describe '#delete' do
    it 'deletes a category link' do
      c = create(:category_link)
      delete "api/category_links/#{c.id}"
      expect(last_response.status).to eq(200)
      expect(CategoryLink.count).to eq(0)
    end
  end
end
