require 'rails_helper'

RSpec.describe Api::InstitutionTagCategoriesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all institution tag category' do
      create(:institution_tag_category)
      create(:institution_tag_category)

      get 'api/institution_tag_categories', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    context 'when params are valid' do
      it 'creates an institution tag category' do
        params = {
            institution_tag_category: {
                title: 'Privé',
                origin: 'BCN',
                position: 5
            }
        }

        post 'api/institution_tag_categories', params.merge(format: 'json')
        expect(last_response.status).to eq(200)
        expect(InstitutionTagCategory.count).to eq(1)
        expect(InstitutionTagCategory.last.title).to eq('Privé')
        expect(InstitutionTagCategory.last.origin).to eq('BCN')
        expect(InstitutionTagCategory.last.position).to eq(5)
      end
    end

    context 'when params are not valid' do
      it 'returns an error' do
        params = {
            institution_tag_category: {
                title: '',
                origin: ''
            }
        }

        post 'api/institution_tag_categories', params.merge(format: 'json')
        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Title can't be blank")
      end
    end
  end

  describe '#update' do
    it 'updates an institution tag category' do
      category = create(:institution_tag_category)
      params = {
          institution_tag_category: {
              title: 'Privé',
              origin: 'BCN',
              position: 3
          }
      }

      put "api/institution_tag_categories/#{category.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(InstitutionTagCategory.last.title).to eq('Privé')
      expect(InstitutionTagCategory.last.origin).to eq('BCN')
      expect(InstitutionTagCategory.last.position).to eq(3)
    end
  end

  describe '#delete' do
    it 'deletes an institution tag category' do
      category = create(:institution_tag_category)
      delete "api/institution_tag_categories/#{category.id}"
      expect(last_response.status).to eq(200)
      expect(InstitutionTagCategory.count).to eq(0)
    end
  end
end
