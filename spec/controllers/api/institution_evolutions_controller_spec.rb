
require 'rails_helper'

RSpec.describe Api::InstitutionEvolutionsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create_predecessor' do
    it 'creates an institution evolution' do
      i = create(:institution)
      predecessor = create(:institution)
      evolution_category = create(:institution_evolution_category)

      params = {
        predecessor: {
          predecessor_id: predecessor.id,
          date: '2018-01-13',
          institution_evolution_category_id: evolution_category.id
        }
      }

      post "api/institutions/#{i.id}/predecessors", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(InstitutionEvolution.count).to eq(1)
      expect(InstitutionEvolution.first.predecessor_id).to eq(predecessor.id)
      expect(InstitutionEvolution.first.date).to eq(Date.new(2018,01,13))
    end
  end

  describe '#index_predecessors' do
    it 'returns all institution predecessors' do
      i = create(:institution)
      create(:institution_evolution, follower_id: i.id)
      create(:institution_evolution, follower_id: i.id)

      get "api/institutions/#{i.id}/predecessors", format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#delete_predecessor' do
    it 'deletes a predecessor link' do
      i = create(:institution)
      predecessor_link = create(:institution_evolution, follower_id: i.id)

      delete "api/institutions/#{i.id}/predecessors/#{predecessor_link.predecessor_id}", format: :json

      expect(last_response.status).to eq(200)
      expect(InstitutionEvolution.count).to eq(0)
    end
  end


  describe '#create_follower' do
    it 'creates an institution follower' do
      i = create(:institution)
      follower = create(:institution)
      evolution_category = create(:institution_evolution_category)

      params = {
          follower: {
              follower_id: follower.id,
              date: '2018-01-13',
              institution_evolution_category_id: evolution_category.id
          }
      }

      post "api/institutions/#{i.id}/followers", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(InstitutionEvolution.count).to eq(1)
      expect(InstitutionEvolution.first.follower_id).to eq(follower.id)
      expect(InstitutionEvolution.first.date).to eq(Date.new(2018,01,13))
    end
  end

  describe '#index_followers' do
    it 'returns all institution followers' do
      i = create(:institution)
      create(:institution_evolution, predecessor_id: i.id)
      create(:institution_evolution, predecessor_id: i.id)

      get "api/institutions/#{i.id}/followers", format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
    end
  end

  describe '#delete_follower' do
    it 'deletes a follower link' do
      i = create(:institution)
      follower_link = create(:institution_evolution, predecessor_id: i.id)

      delete "api/institutions/#{i.id}/followers/#{follower_link.follower_id}", format: :json

      expect(last_response.status).to eq(200)
      expect(InstitutionEvolution.count).to eq(0)
    end
  end
end
