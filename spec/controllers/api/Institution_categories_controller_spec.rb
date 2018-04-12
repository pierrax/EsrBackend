require 'rails_helper'

RSpec.describe Api::InstitutionCategoriesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create' do
    it 'creates an institution category' do
      label = create(:institution_category_label)
      i = create(:institution)
      params = {
          institution_category: {
              institution_category_label_id: label.id
          }
      }

      post "api/institutions/#{i.id}/institution_categories", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(i.categories.count).to eq(1)
      expect(i.categories.first.label.short_label).to eq(label.short_label)
    end
  end

  describe '#update' do
    it 'updates an institution category' do
      l = create(:institution_category)
      new_label = create(:institution_category_label)
      params = {
          institution_category: {
              institution_category_label_id: new_label.id
          }
      }

      put "api/institution_categories/#{l.id}", params.merge(format: 'json')

      l.reload
      expect(last_response.status).to eq(200)
      expect(l.institution_category_label_id).to eq(new_label.id)
    end
  end

  describe '#delete' do
    it 'deletes an institution category' do
      l = create(:institution_category)
      delete "api/institution_categories/#{l.id}"
      expect(last_response.status).to eq(200)
      expect(InstitutionCategory.count).to eq(0)
    end
  end
end
