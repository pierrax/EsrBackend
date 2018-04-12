require 'rails_helper'

RSpec.describe Api::CodesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create' do
    let(:code_category) { create(:code_category) }

    it 'creates a code' do
      i = create(:institution)
      params = {
        code: {
          content: 'XXX111XXX',
          code_category_id: code_category.id
        }
      }

      post "api/institutions/#{i.id}/codes", params.merge(format: 'json')
      expect(last_response.status).to eq(200)
      expect(i.codes.count).to eq(1)
      expect(i.codes.first.content).to eq('XXX111XXX')
    end
  end

  describe '#update' do
    it 'updates a code' do
      l = create(:code)
      params = {
        code: {
          content: 'NEWCODE'
        }
      }

      put "api/codes/#{l.id}", params.merge(format: 'json')

      l.reload
      expect(last_response.status).to eq(200)
      expect(l.content).to eq('NEWCODE')
    end
  end

  describe '#delete' do
    it 'deletes a code' do
      l = create(:code)
      delete "api/codes/#{l.id}"
      expect(last_response.status).to eq(200)
      expect(Code.count).to eq(0)
    end
  end
end
