require 'rails_helper'

RSpec.describe Api::CodesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create' do
    context 'when params are valid' do
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

    context 'when params are not valid' do
      context 'when archived params' do
        it 'returns an error' do
          i = create(:institution)
          params = {
            code: {
              content: ''
            }
          }

          post "api/institutions/#{i.id}/codes", params.merge(format: 'json')
          expect(last_response.status).to eq(404)
          expect(json_response).to eq("Category must exist, Content can't be blank")
        end
      end
    end
  end

  describe '#index' do
    it 'returns all codes ordered by category' do
      cc_1 = create(:code_category, position: 1, title: 'CC1')
      cc_2 = create(:code_category, position: 10, title: 'CC2')
      cc_3 = create(:code_category, position: 5, title: 'CC3')

      i = create(:institution)
      create(:code, institution_id: i.id, category: cc_1)
      create(:code, institution_id: i.id, category: cc_2)
      create(:code, institution_id: i.id, category: cc_3)

      get "api/institutions/#{i.id}/codes", format: :json
      expect(last_response.status).to eq(200)
      expect(json_response.count).to eq(3)
      expect(json_response[0][:category]).to eq('CC1')
      expect(json_response[1][:category]).to eq('CC3')
      expect(json_response[2][:category]).to eq('CC2')
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

  describe '#search' do
    context 'when code is active' do
      it 'returns an institution' do
        i = create(:institution)
        code = create(:code, institution_id: i.id)

        post "api/codes/search?q=#{code.content}", format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(1)
        expect(json_response[:institution][:codes].first[:content]).to eq(code.content)
      end
    end

    context 'when code is not active' do
      it 'returns an institution without code' do
        i = create(:institution)
        code = create(:code, institution_id: i.id, status: 'archived')

        post "api/codes/search?q=#{code.content}&status=active", format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(1)
        expect(json_response[:institution][:codes]).to eq([])
      end
    end
  end

  describe '#import' do
    context 'when the file is valid' do
      it 'creates 4 new codes' do
        DatabaseCleaner.clean_with :truncation
        file = Rack::Test::UploadedFile.new (fixture_path + '/codes.csv'), 'text/csv'
        create(:institution)
        create(:code_category)

        post 'api/codes/import', file: file

        expect(last_response.status).to eq(200)
        expect(Code.count).to eq(4)
        expect(Code.last.content).to eq('111')
      end
    end

    context 'when the file is invalid' do
      it 'creates 0 new codes and returns an error' do
        DatabaseCleaner.clean_with :truncation
        file = Rack::Test::UploadedFile.new (fixture_path + '/wrong_codes.csv'), 'text/csv'
        create(:institution)
        create(:code_category)

        post 'api/codes/import', file: file

        expect(last_response.status).to eq(401)
        expect(json_response[:message]).to eq("Ligne 4: Institution must exist, Category must exist")
        expect(Code.count).to eq(0)
      end
    end
  end
end
