require 'rails_helper'

RSpec.describe Api::LinksController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    let(:link_category) { create(:link_category) }

    it 'returns all links' do
      i = create(:institution)
      create(:link, institution_id: i.id)
      create(:link, institution_id: i.id)

      get "api/institutions/#{i.id}/links", format: :json
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    let(:link_category) { create(:link_category) }

    it 'creates a link' do
      i = create(:institution)
      params = {
        link: {
          content: 'www.dataesr.com',
          link_category_id: link_category.id
        }
      }

      post "api/institutions/#{i.id}/links", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(i.links.count).to eq(1)
      expect(i.links.first.content).to eq('www.dataesr.com')
    end
  end

  describe '#update' do
    it 'updates a link' do
      l = create(:link)
      params = {
        link: {
          content: 'www.new-url.com'
        }
      }

      put "api/links/#{l.id}", params.merge(format: 'json')

      l.reload
      expect(last_response.status).to eq(200)
      expect(l.content).to eq('www.new-url.com')
    end
  end

  describe '#delete' do
    it 'deletes a link' do
      l = create(:link)
      delete "api/links/#{l.id}"
      expect(last_response.status).to eq(200)
      expect(Link.count).to eq(0)
    end
  end
end
