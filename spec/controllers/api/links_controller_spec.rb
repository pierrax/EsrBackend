require 'rails_helper'

RSpec.describe Api::LinksController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do

    it 'returns all links ordered by category' do
      link_category_1 = create(:link_category, position: 1)
      link_category_2 = create(:link_category, position: 5)
      link_category_3 = create(:link_category, position: 10)

      i = create(:institution)
      create(:link, institution_id: i.id, category: link_category_2)
      create(:link, institution_id: i.id, category: link_category_3)
      create(:link, institution_id: i.id, category: link_category_1)

      get "api/institutions/#{i.id}/links", format: :json
      expect(last_response.status).to eq(200)
      expect(json_response.count).to eq(3)
      expect(json_response[0][:category]).to eq(link_category_1.title)
      expect(json_response[1][:category]).to eq(link_category_2.title)
      expect(json_response[2][:category]).to eq(link_category_3.title)
    end
  end

  describe '#create' do
    let(:link_category) { create(:link_category) }

    context 'when params are valid' do
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

    context 'when params are not valid' do
      it 'returns an error' do
        i = create(:institution)
        params = {
            link: {
                content: '',
                link_category_id: ''
            }
        }

        post "api/institutions/#{i.id}/links", params.merge(format: 'json')
        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Category must exist, Content can't be blank")
      end
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

  describe '#import' do
    context 'when the file is valid' do
      let(:file) { Rack::Test::UploadedFile.new (fixture_path + '/links.csv'), 'text/csv' }

      it 'creates 3 links' do
        DatabaseCleaner.clean_with :truncation
        create(:institution)
        category = create(:link_category, title: 'website')

        post 'api/links/import', file: file

        expect(last_response.status).to eq(200)
        expect(Link.count).to eq(3)
        expect(Link.last.content).to eq('www.esr3.com')
        expect(Link.last.category).to eq(category)
      end
    end

    context 'when the file is invalid' do
      let(:file) { Rack::Test::UploadedFile.new (fixture_path + '/wrong_links.csv'), 'text/csv' }

      it 'creates 0 links and returns an error' do
        DatabaseCleaner.clean_with :truncation
        create(:institution)
        category = create(:link_category, title: 'website')

        post 'api/links/import', file: file

        expect(last_response.status).to eq(401)
        expect(json_response[:message]).to eq("Ligne 2: Institution must exist; Ligne 4: Institution must exist")
        expect(Link.count).to eq(0)
      end
    end
  end
end
