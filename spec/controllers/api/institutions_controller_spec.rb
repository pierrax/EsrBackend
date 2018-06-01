require 'rails_helper'

RSpec.describe Api::InstitutionsController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#index' do
    it 'returns all institutions' do
      50.times { create(:institution) }

      get 'api/institutions', format: :json

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(20)
      expect(last_response.header['Link'].split(',')[0]).to eq("<http://example.org/api/institutions?format=json&page_number=1&page_size=20>; rel=\"self\"")
      expect(last_response.header['Link'].split(',')[1].strip).to eq("<http://example.org/api/institutions?format=json&page_number=2&page_size=20>; rel=\"next\"")
      expect(last_response.header['Link'].split(',')[2].strip).to eq("<http://example.org/api/institutions?format=json&page_number=3&page_size=20>; rel=\"last\"")
    end
  end

  describe '#create' do
    context 'when no name is given' do
      it 'creates an institution' do
        params = {
          institution: {
            date_start: Date.current
          }
        }

        post 'api/institutions', params.merge(format: 'json')
        expect(last_response.status).to eq(200)
        expect(Institution.last.names.first).to be_nil
      end
    end

    context 'when a name is given' do
      it 'creates an institution' do
        params = {
          institution: {
            date_start: Date.current,
            name: 'New Uni',
            initials: 'UNI'
          }
        }

        post 'api/institutions', params.merge(format: 'json')
        expect(last_response.status).to eq(200)
        expect(Institution.last.names.first.text).to eq('New Uni')
        expect(Institution.last.names.first.initials).to eq('UNI')
      end
    end
  end

  describe '#update' do
    context 'when params are valid' do
      it 'updates an institution' do
        i = create(:institution)
        params = {
          institution: {
            id: i.id,
            date_start: Date.current - 2.days,
            synonym: 'Uni sckool'
          }
        }

        put "api/institutions/#{i.id}", params.merge(format: 'json')
        i.reload

        expect(last_response.status).to eq(200)
        expect(i.date_start).to eq(Date.current - 2.days)
        expect(i.synonym).to eq('Uni sckool')
      end
    end

    context 'when params are not valid' do
      it 'raises an error' do
        i = create(:institution)
        params = {
          institution: {
            id: i.id,
            date_start: 'New Uni'
          }
        }

        put "api/institutions/#{i.id}", params.merge(format: 'json')
        i.reload

        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Date start can't be blank")
      end
    end
  end

  describe '#delete' do
    it 'deletes an institution' do
      i = create(:institution)
      delete "api/institutions/#{i.id}"
      expect(last_response.status).to eq(200)
      expect(Institution.count).to eq(0)
    end
  end

  describe '#search' do
    context 'when institution name mixes case' do
      it 'returns an institution' do
        35.times do
          i = create(:institution)
          i.names.first.update(text: 'abCde')
        end

        post 'api/institutions/search?q=ABC', format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(20)
        expect(last_response.header['Link'].split(',')[0]).to eq("<http://example.org/api/institutions/search?q=ABC&page_number=1&page_size=20>; rel=\"self\"")
        expect(last_response.header['Link'].split(',')[1].strip).to eq("<http://example.org/api/institutions/search?q=ABC&page_number=2&page_size=20>; rel=\"next\"")
        expect(last_response.header['Link'].split(',')[2].strip).to eq("<http://example.org/api/institutions/search?q=ABC&page_number=2&page_size=20>; rel=\"last\"")


        post 'api/institutions/search?q=ABC&page_number=2&page_size=20', format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(20)
        expect(last_response.header['Link'].split(',')[0]).to eq("<http://example.org/api/institutions/search?q=ABC&page_number=2&page_size=20>; rel=\"self\"")
        expect(last_response.header['Link'].split(',')[1].strip).to eq("<http://example.org/api/institutions/search?q=ABC&page_number=1&page_size=20>; rel=\"first\"")
        expect(last_response.header['Link'].split(',')[2].strip).to eq("<http://example.org/api/institutions/search?q=ABC&page_number=1&page_size=20>; rel=\"prev\"")
      end
    end

    context 'when match is in institution initials' do
      it 'returns an institution' do
        i = create(:institution)
        i.names.first.update(text: 'XXXX', initials: 'xxabcxx')

        post 'api/institutions/search?q=ABC', format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(1)
      end
    end

    context 'when match is in institution synonym' do
      it 'returns an institution' do
        i = create(:institution, synonym: '123 abx abc')

        post 'api/institutions/search?q=ABC', format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(1)
      end
    end

    context 'when no match in institution name or initials' do
      it 'returns an empty array' do
        i = create(:institution, synonym: 'xxx aaa')
        i.names.first.update(text: 'aaaaa', initials: 'bbbbb')

        post 'api/institutions/search?q=ABC', format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(0)

        expect(last_response.header['Link'].split(',')[0]).to eq("<http://example.org/api/institutions/search?q=ABC&page_number=1&page_size=20>; rel=\"self\"")
      end
    end

    context 'when params donwload is true' do
      it 'returns the url the CSV file in the body' do
        i = create(:institution)
        i.names.first.update(text: 'aaaaa', initials: 'bbbbb')

        post 'api/institutions/search?q=a&download=true', format: 'json'

        expect(last_response.status).to eq(200)
      end
    end
  end

  describe '#import' do
    context 'when the file is valid' do
      let(:file) { Rack::Test::UploadedFile.new (fixture_path + '/institutions.csv'), 'text/csv' }

      it 'creates 2 institutions' do
        DatabaseCleaner.clean_with :truncation
        create(:code_category, title: 'uai')

        post 'api/institutions/import', file: file

        expect(last_response.status).to eq(200)
        expect(Institution.count).to eq(2)
        expect(Institution.last.date_start).to eq(Date.new(2000, 01, 01))
        expect(Institution.last.codes.first.content).to eq('Uaaa33bbb')
        expect(Institution.last.names.first.text).to eq('Central')
        expect(Institution.last.names.first.initials).to eq('CCC')
        expect(Institution.last.addresses.first.business_name).to eq('Central')
        expect(Institution.last.addresses.first.address_1).to eq('1 rue des bois')
        expect(Institution.last.addresses.first.address_2).to be_nil
        expect(Institution.last.addresses.first.zip_code).to eq('92150')
        expect(Institution.last.addresses.first.city).to eq('Suresnes')
        expect(Institution.last.addresses.first.country).to eq('France')
        expect(Institution.last.addresses.first.phone).to eq('0100990099')
      end
    end

    context 'when the file is invalid' do
      let(:file) { Rack::Test::UploadedFile.new (fixture_path + '/wrong_institutions.csv'), 'text/csv' }

      it 'creates 0 institutions and returns an error' do
        DatabaseCleaner.clean_with :truncation
        create(:code_category, title: 'uai')

        post 'api/institutions/import', file: file

        expect(last_response.status).to eq(401)
        expect(Institution.count).to eq(0)
        expect(json_response[:message]).to eq("Ligne 3: Names text can't be blank, Names text is too short (minimum is 2 characters); Ligne 3: Text can't be blank, Text is too short (minimum is 2 characters)")
      end
    end
  end

  describe '#last' do
    context 'when no size params given' do
      it 'returns 20 last institutions' do
        35.times { create(:institution) }

        get 'api/institutions/last', format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(20)
        expect(last_response.header['Link'].split(',')[0]).to eq("<http://example.org/api/institutions/last?format=json&page_number=1&page_size=20>; rel=\"self\"")
      end
    end

    context 'when size params is 5' do
      it 'returns 5 last institutions' do
        15.times { create(:institution) }

        get 'api/institutions/last?size=5', format: 'json'

        expect(last_response.status).to eq(200)
        expect(json_response.count).to eq(5)
        expect(last_response.header['Link'].split(',')[0]).to eq("<http://example.org/api/institutions/last?format=json&size=5&page_number=1&page_size=20>; rel=\"self\"")
      end
    end
  end
end
