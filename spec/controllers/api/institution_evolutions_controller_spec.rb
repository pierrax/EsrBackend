
require 'rails_helper'

RSpec.describe Api::InstitutionEvolutionsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create_predecessor' do
    context 'when params are valid' do
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
        expect(i.predecessors.last).to eq(predecessor)
        expect(InstitutionEvolution.last.date).to eq(Date.new(2018,01,13))
      end
    end

    context 'when params are valid' do
      it 'creates an institution evolution' do
        i = create(:institution)

        params = {
          predecessor: {
            predecessor_id: '',
            date: '',
            institution_evolution_category_id: ''
          }
        }

        post "api/institutions/#{i.id}/predecessors", params.merge(format: 'json')

        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Predecessor must exist, Category must exist, Predecessor can't be blank, Institution evolution category can't be blank")
      end
    end

  end

  describe '#index_predecessors' do
    it 'returns all institution predecessors' do
      i = create(:institution)
      create(:institution_evolution, follower_id: i.id)
      create(:institution_evolution, follower_id: i.id)

      get "api/institutions/#{i.id}/predecessors", format: :json

      expect(last_response.status).to eq(200)
      expect(json_response[:evolutions].count).to eq(2)
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
    context 'when params are valid' do
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
        expect(i.followers.last).to eq(follower)
        expect(InstitutionEvolution.first.date).to eq(Date.new(2018,01,13))
      end
    end

    context 'when params are not valid' do
      it 'returns an error' do
        i = create(:institution)

        params = {
            follower: {
                follower_id: '',
                date: '',
                institution_evolution_category_id: ''
            }
        }

        post "api/institutions/#{i.id}/followers", params.merge(format: 'json')

        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Follower must exist, Category must exist, Follower can't be blank, Institution evolution category can't be blank")
      end
    end

  end

  describe '#index_followers' do
    it 'returns all institution followers' do
      i = create(:institution)
      create(:institution_evolution, predecessor_id: i.id)
      create(:institution_evolution, predecessor_id: i.id)

      get "api/institutions/#{i.id}/followers", format: :json

      expect(last_response.status).to eq(200)
      expect(json_response[:evolutions].count).to eq(2)
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

  describe '#import' do
    context 'when the file is valid' do
      it 'creates 3 evolutions' do
        DatabaseCleaner.clean_with :truncation
        file = Rack::Test::UploadedFile.new (fixture_path + '/evolutions.csv'), 'text/csv'
        4.times { create(:institution) }
        create(:institution_evolution_category)

        post 'api/evolutions/import', file: file

        expect(last_response.status).to eq(200)
        expect(InstitutionEvolution.count).to eq(3)
        expect(InstitutionEvolution.last.predecessor_id).to eq(1)
      end
    end

    context 'when the file is invalid' do
      it 'creates 0 evolutions and returns an error' do
        DatabaseCleaner.clean_with :truncation
        file = Rack::Test::UploadedFile.new (fixture_path + '/wrong_evolutions.csv'), 'text/csv'
        4.times { create(:institution) }
        create(:institution_evolution_category)

        post 'api/evolutions/import', file: file

        expect(last_response.status).to eq(401)
        expect(json_response[:message]).to eq('Ligne 3: Predecessor must exist')
        expect(InstitutionEvolution.count).to eq(0)
      end
    end
  end
end
