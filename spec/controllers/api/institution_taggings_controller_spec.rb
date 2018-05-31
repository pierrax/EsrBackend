require 'rails_helper'

RSpec.describe Api::InstitutionTaggingsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    context 'when institution has tags' do
      it 'returns tags' do
        i = create(:institution)
        create(:institution_tagging, institution: i)

        get "api/institutions/#{i.id}/tags", format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(1)
      end
    end
  end

  describe '#create' do
    context 'when params are valid' do
      context 'when institution has no tags' do
        it 'adds tag' do
          i = create(:institution)
          tag = create(:institution_tag)
          params = {
            institution_tagging: {
              date_start: Date.new(2018, 01, 01),
              date_end: Date.new(2018, 01, 01)
            }
          }

          post "api/institutions/#{i.id}/tags/#{tag.id}", params.merge(format: 'json')

          expect(last_response.status).to eq(200)
          expect(i.tags.count).to eq(1)
          expect(i.tags.first).to eq(tag)
          expect(json_response[:institution_tagging][:date_start]).to eq('2018-01-01')
          expect(json_response[:institution_tagging][:date_end]).to eq('2018-01-01')
        end
      end

      context 'when institution has already this tag' do
        it 'returns an error' do
          i = create(:institution)
          tagging = create(:institution_tagging, institution: i)

          post "api/institutions/#{i.id}/tags/#{tagging.institution_tag.id}", format: 'json'

          expect(last_response.status).to eq(302)
          expect(i.tags.count).to eq(1)
        end
      end
    end

    context 'when params are not valid' do
      context 'when institution has no tags' do
        it 'returns an error' do
          i = create(:institution)
          params = {
              institution_tagging: {
                  date_start: '',
                  date_end: ''
              }
          }

          post "api/institutions/#{i.id}/tags/123", params.merge(format: 'json')

          expect(last_response.status).to eq(404)
          expect(json_response).to eq('Record not found')
        end
      end
    end
  end

  describe '#update' do
    it 'update tagging' do
      i = create(:institution)
      tagging = create(:institution_tagging, institution: i)
      params = {
        institution_tagging: {
          date_start: Date.new(2018, 01, 01),
          date_end: Date.new(2018, 01, 01)
        }
      }

      put "api/institution_taggings/#{tagging.id}", params.merge(format: 'json')

      expect(last_response.status).to eq(200)
      expect(json_response[:institution_tagging][:date_start]).to eq('2018-01-01')
      expect(json_response[:institution_tagging][:date_end]).to eq('2018-01-01')
    end
  end

  describe '#delete' do
    context 'when institution has one tag' do
      it 'returns an error' do
        i = create(:institution)
        tagging = create(:institution_tagging, institution: i)

        delete "api/institutions/#{i.id}/tags/#{tagging.institution_tag.id}", format: 'json'

        expect(last_response.status).to eq(200)
        expect(i.tags.count).to eq(0)
      end
    end

    context 'when institution has no tags' do
      it 'returns an error' do
        i = create(:institution)
        tag = create(:institution_tag)

        delete "api/institutions/#{i.id}/tags/#{tag.id}", format: 'json'

        expect(last_response.status).to eq(302)
        expect(i.tags.count).to eq(0)
      end
    end

    context 'when institution has not this tag' do
      it 'returns an error' do
        i = create(:institution)
        tagging = create(:institution_tagging, institution: i)
        tag = create(:institution_tag)

        delete "api/institutions/#{i.id}/tags/#{tag.id}", format: 'json'

        expect(last_response.status).to eq(302)
        expect(i.tags.count).to eq(1)
      end
    end
  end

  describe '#import' do
    context 'when the file is valid' do
      it 'creates 3 taggings' do
        DatabaseCleaner.clean_with :truncation
        file = Rack::Test::UploadedFile.new (fixture_path + '/taggings.csv'), 'text/csv'
        create(:institution)
        3.times { create(:institution_tag) }

        post 'api/taggings/import', file: file

        expect(last_response.status).to eq(200)
        expect(InstitutionTagging.count).to eq(3)
        expect(InstitutionTagging.last.institution_tag_id).to eq(3)
      end
    end

    context 'when the file is invalid' do
      it 'creates 0 taggings and returns an error' do
        DatabaseCleaner.clean_with :truncation
        file = Rack::Test::UploadedFile.new (fixture_path + '/wrong_taggings.csv'), 'text/csv'
        create(:institution)
        3.times { create(:institution_tag) }

        post 'api/taggings/import', file: file

        expect(last_response.status).to eq(401)
        expect(json_response[:message]).to eq('Ligne 3: Institution must exist')
        expect(InstitutionTagging.count).to eq(0)
      end
    end
  end
end
