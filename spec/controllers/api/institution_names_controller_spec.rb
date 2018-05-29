require 'rails_helper'

RSpec.describe Api::InstitutionNamesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create' do
    context 'when params are valid' do
      context 'when  no archived params' do
        it 'creates an active name and sets others to archived' do
          i = create(:institution)

          params = {
              institution_name: {
                  text: 'Sorbonne 12',
                  initials: 'SO'
              }
          }

          post "api/institutions/#{i.id}/institution_names", params.merge(format: 'json')

          i.reload
          expect(last_response.status).to eq(200)
          expect(i.names.count).to eq(2)
          expect(i.names.last.text).to eq('Sorbonne 12')
          expect(i.names.last.initials).to eq('SO')
          expect(i.names.last.status).to eq('active')
          expect(i.names.first.status).to eq('archived')
        end
      end

      context 'when archived params' do
        it 'creates an archived name and does not set active others to archived' do
          i = create(:institution)
          archived_name = create(:institution_name, institution: i, status: 'archived')

          params = {
              institution_name: {
                  text: 'Sorbonne 12',
                  initials: 'SO',
                  status: 'archived'
              }
          }

          post "api/institutions/#{i.id}/institution_names", params.merge(format: 'json')

          i.reload
          expect(last_response.status).to eq(200)
          expect(i.names.count).to eq(3)
          expect(i.names.last.text).to eq('Sorbonne 12')
          expect(i.names.last.initials).to eq('SO')
          expect(i.names.last.status).to eq('archived')
          expect(archived_name.reload.status).to eq('archived')
          expect(i.names.first.status).to eq('active')
        end
      end
    end

    context 'when params are not valid' do
      it 'returns an error' do
        i = create(:institution)

        params = {
          institution_name: {
            text: 'S',
            initials: ''
          }
        }

        post "api/institutions/#{i.id}/institution_names", params.merge(format: 'json')
        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Text is too short (minimum is 2 characters), Initials can't be blank, Initials is too short (minimum is 2 characters)")
      end
    end
  end

  describe '#index' do
    it 'returns all names' do
      i = create(:institution)
      create(:institution_name, institution: i)
      create(:institution_name, institution: i)

      get "api/institutions/#{i.id}/institution_names", format: :json
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(3)
    end
  end

  describe '#update' do
    it 'updates a name' do
      name = create(:institution_name)

      params = {
        institution_name: {
          text: 'NEW NAME'
        }
      }

      put "api/institution_names/#{name.id}", params.merge(format: 'json')

      name.reload
      expect(last_response.status).to eq(200)
      expect(name.text).to eq('NEW NAME')
    end
  end

  describe '#delete' do
    it 'deletes a name' do
      name = create(:institution_name)
      expect {
        delete "api/institution_names/#{name.id}"
      }.to change(InstitutionName, :count).by(-1)
    end
  end
end
