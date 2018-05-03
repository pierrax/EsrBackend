require 'rails_helper'

RSpec.describe Api::CodesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create' do
    context 'when  no archived params' do
      it 'creates a code and set others from the same category to archived' do
        grid_category = create(:code_category, title: 'GRID')
        uai_category = create(:code_category, title: 'UAI')
        siren_category = create(:code_category, title: 'SIREN')
        i = create(:institution)
        grid_code = create(:code, institution_id: i.id, code_category_id: grid_category.id)
        uai_code = create(:code, institution_id: i.id, code_category_id: uai_category.id)
        old_siren_code = create(:code, institution_id: i.id, code_category_id: siren_category.id)

        params = {
          code: {
            content: 'XXX111XXX',
            code_category_id: siren_category.id
          }
        }

        post "api/institutions/#{i.id}/codes", params.merge(format: 'json')

        grid_code.reload
        uai_code.reload
        old_siren_code.reload
        expect(last_response.status).to eq(200)
        expect(i.codes.count).to eq(4)
        expect(i.codes.last.content).to eq('XXX111XXX')
        expect(i.codes.last.status).to eq('active')
        expect(grid_code.status).to eq('active')
        expect(uai_code.status).to eq('active')
        expect(old_siren_code.status).to eq('archived')
      end
    end

    context 'when archived params' do
      it 'creates a code' do
        code_category = create(:code_category)
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
  end

  describe '#index' do
    let(:code_category) { create(:code_category) }

    it 'returns all codes' do
      i = create(:institution)
      create(:code, institution_id: i.id)
      create(:code, institution_id: i.id)

      get "api/institutions/#{i.id}/codes", format: :json
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(2)
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
