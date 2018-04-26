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
end