require 'rails_helper'

RSpec.describe Api::LinkCategoriesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all category links' do
      create(:link_category)
      create(:link_category)

      get 'api/link_categories', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    context 'when params are valid' do
      it 'creates a category link' do
        params = {
          link_category: {
            title: 'Facebook',
            position: 10
          }
        }

        post 'api/link_categories', params.merge(format: 'json')
        expect(last_response.status).to eq(200)
        expect(LinkCategory.count).to eq(1)
        expect(LinkCategory.last.position).to eq(10)
      end
    end

    context 'when params are not valid' do
      it 'returns an error' do
        params = {
            link_category: {
                title: ''
            }
        }

        post 'api/link_categories', params.merge(format: 'json')
        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Title can't be blank")
      end
    end
  end

  describe '#update' do
    it 'updates a category link' do
      c = create(:link_category)
      params = {
        link_category: {
          title: 'Facebook',
          position: 5
        }
      }

      put "api/link_categories/#{c.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(LinkCategory.last.title).to eq('Facebook')
      expect(LinkCategory.last.position).to eq(5)
    end
  end

  describe '#delete' do
    it 'deletes a category link' do
      c = create(:link_category)
      delete "api/link_categories/#{c.id}"
      expect(last_response.status).to eq(200)
      expect(LinkCategory.count).to eq(0)
    end
  end
end
