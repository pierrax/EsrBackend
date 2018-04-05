require 'rails_helper'

RSpec.describe Api::InstitutionsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all institutions' do
      create(:institution)
      create(:institution)

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

  describe '#search' do
    context 'when institution name mixes case' do
      it 'returns an institution' do
        i = create(:institution)
        i.names.first.update(text: 'abCde')

        post 'api/institutions/search?q=ABC', format: 'json'

        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body).count).to eq(1)
      end
    end

    context 'when match is in institution initials' do
      it 'returns an institution' do
        i = create(:institution)
        i.names.first.update(text: 'XXXX', initials: 'xxabcxx')

        post 'api/institutions/search?q=ABC', format: 'json'

        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body).count).to eq(1)
      end
    end

    context 'when no match in institution name or initials' do
      it 'returns an empty array' do
        i = create(:institution)
        i.names.first.update(text: 'aaaaa', initials: 'bbbbb')

        post 'api/institutions/search?q=ABC', format: 'json'

        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body).count).to eq(0)
      end
    end
  end
end
