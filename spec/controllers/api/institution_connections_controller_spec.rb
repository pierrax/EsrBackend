
require 'rails_helper'

RSpec.describe Api::InstitutionConnectionsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create_mother' do
    it 'creates an institution connection' do
      i = create(:institution)
      mother = create(:institution)
      connection_category = create(:institution_connection_category)

      params = {
          mother: {
              mother_id: mother.id,
              date: '2018-01-13',
              institution_connection_category_id: connection_category.id
          }
      }

      post "api/institutions/#{i.id}/mothers", params.merge(format: 'json')

      expect(last_response.status).to eq(200)
      expect(InstitutionConnection.count).to eq(1)
      expect(i.mothers.last).to eq(mother)
      expect(InstitutionConnection.last.date).to eq(Date.new(2018,01,13))
    end
  end

  describe '#index_mothers' do
    it 'returns all institution mothers' do
      i = create(:institution)
      create(:institution_connection, daughter_id: i.id)
      create(:institution_connection, daughter_id: i.id)

      get "api/institutions/#{i.id}/mothers", format: :json

      expect(last_response.status).to eq(200)
      expect(json_response[:connections].count).to eq(2)
    end
  end

  describe '#delete_mother' do
    it 'deletes a mother link' do
      i = create(:institution)
      mother_link = create(:institution_connection, daughter_id: i.id)

      delete "api/institutions/#{i.id}/mothers/#{mother_link.mother_id}", format: :json

      expect(last_response.status).to eq(200)
      expect(InstitutionConnection.count).to eq(0)
    end
  end


  describe '#create_daughter' do
    it 'creates an institution daughter' do
      i = create(:institution)
      daughter = create(:institution)
      connection_category = create(:institution_connection_category)

      params = {
          daughter: {
              daughter_id: daughter.id,
              date: '2018-01-13',
              institution_connection_category_id: connection_category.id
          }
      }

      post "api/institutions/#{i.id}/daughters", params.merge(format: 'json')

      expect(last_response.status).to eq(200)
      expect(InstitutionConnection.count).to eq(1)
      expect(i.daughters.last).to eq(daughter)
      expect(InstitutionConnection.first.date).to eq(Date.new(2018,01,13))
    end
  end

  describe '#index_daughters' do
    it 'returns all institution daughters' do
      i = create(:institution)
      create(:institution_connection, mother_id: i.id)
      create(:institution_connection, mother_id: i.id)

      get "api/institutions/#{i.id}/daughters", format: :json

      expect(last_response.status).to eq(200)
      expect(json_response[:connections].count).to eq(2)
    end
  end

  describe '#delete_daughter' do
    it 'deletes a daughter link' do
      i = create(:institution)
      daughter_link = create(:institution_connection, mother_id: i.id)

      delete "api/institutions/#{i.id}/daughters/#{daughter_link.daughter_id}", format: :json

      expect(last_response.status).to eq(200)
      expect(InstitutionConnection.count).to eq(0)
    end
  end
end
