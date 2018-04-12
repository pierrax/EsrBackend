require 'rails_helper'

RSpec.describe Api::InstitutionCategoryLabelsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all institution category label' do
      create(:institution_category_label)
      create(:institution_category_label)

      get 'api/institution_category_labels', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#create' do
    it 'creates an institution category label' do
      params = {
          institution_category_label: {
              short_label: 'Université',
              long_label: "Université d'enseignement supérieur"
          }
      }

      post 'api/institution_category_labels', params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(InstitutionCategoryLabel.count).to eq(1)
    end
  end

  describe '#update' do
    it 'updates an institution category label' do
      label = create(:institution_category_label)
      params = {
          institution_category_label: {
              short_label: 'new short',
              long_label: 'new long'
          }
      }

      put "api/institution_category_labels/#{label.id}", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(InstitutionCategoryLabel.last.short_label).to eq('new short')
      expect(InstitutionCategoryLabel.last.long_label).to eq('new long')
    end
  end

  describe '#delete' do
    it 'deletes an institution category label' do
      label = create(:institution_category_label)
      delete "api/institution_category_labels/#{label.id}"
      expect(last_response.status).to eq(200)
      expect(InstitutionCategoryLabel.count).to eq(0)
    end
  end
end
