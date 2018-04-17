require 'rails_helper'

RSpec.describe Api::InstitutionEvolutionCategoriesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create' do
    it 'creates an institution evolution category' do
      params = {
          institution_evolution_category: {
              title: 'Fusion'
          }
      }

      post 'api/institution_evolution_categories', params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(InstitutionEvolutionCategory.count).to eq(1)
      expect(InstitutionEvolutionCategory.first.title).to eq('Fusion')
    end
  end

  describe '#index' do
    it 'returns all institution evolution categories' do
      create(:institution_evolution_category)
      create(:institution_evolution_category)

      get 'api/institution_evolution_categories', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#update' do
    it 'updates an institution evolution category' do
      c = create(:institution_evolution_category)
      params = {
          institution_evolution_category: {
              title: 'Merge'
          }
      }

      put "api/institution_evolution_categories/#{c.id}", params.merge(format: 'json')

      c.reload
      expect(last_response.status).to eq(200)
      expect(c.title).to eq('Merge')
    end
  end

  describe '#delete' do
    it 'deletes an institution evolution category' do
      l = create(:institution_evolution_category)
      delete "api/institution_evolution_categories/#{l.id}"
      expect(last_response.status).to eq(200)
      expect(InstitutionEvolutionCategory.count).to eq(0)
    end
  end
end
