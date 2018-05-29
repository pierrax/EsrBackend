require 'rails_helper'

RSpec.describe Api::InstitutionTagsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all institution tag' do
      create(:institution_tag)
      create(:institution_tag)

      get 'api/institution_tags', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    context 'when params are valid' do
      it 'creates an institution tag' do
        category = create(:institution_tag_category)
        params = {
            institution_tag: {
                short_label: 'PV',
                long_label: 'Privé',
                institution_tag_category_id: category.id
            }
        }

        post 'api/institution_tags', params.merge(format: 'json')
        expect(last_response.status).to eq(200)
        expect(InstitutionTag.count).to eq(1)
        expect(InstitutionTag.last.short_label).to eq('PV')
        expect(InstitutionTag.last.long_label).to eq('Privé')
        expect(InstitutionTag.last.category).to eq(category)
      end
    end

    context 'when params are not valid' do
      it 'returns an error' do
        category = create(:institution_tag_category)
        params = {
            institution_tag: {
                short_label: '',
                long_label: '',
                institution_tag_category_id: ''
            }
        }

        post 'api/institution_tags', params.merge(format: 'json')
        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Category must exist, Short label can't be blank, Long label can't be blank")
      end
    end
  end

  describe '#update' do
    it 'updates an institution tag' do
      category = create(:institution_tag)
      params = {
          institution_tag: {
              short_label: 'PV',
              long_label: 'Privé'
          }
      }

      put "api/institution_tags/#{category.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(InstitutionTag.last.short_label).to eq('PV')
      expect(InstitutionTag.last.long_label).to eq('Privé')
    end
  end

  describe '#delete' do
    it 'deletes an institution tag' do
      category = create(:institution_tag)
      delete "api/institution_tags/#{category.id}"
      expect(last_response.status).to eq(200)
      expect(InstitutionTag.count).to eq(0)
    end
  end
end
