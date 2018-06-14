require 'rails_helper'

RSpec.describe Api::AddressesController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#create' do
    context 'when params are valid' do
      context 'when  no archived params' do
        it 'creates an active address and sets others to archived' do
          i = create(:institution)

          params = {
            address: {
              business_name: 'Sorbonne 12',
              address_1: '1 rue des écoles',
              address_2: '',
              zip_code: '75005',
              city: 'Paris',
              country: 'France',
              phone: '0101010101',
              latitude: 2.00,
              longitude: 4.00,
              city_code: 111
            }
          }

          post "api/institutions/#{i.id}/addresses", params.merge(format: 'json')

          i.reload
          expect(last_response.status).to eq(200)
          expect(i.addresses.count).to eq(2)
          expect(i.addresses.last.business_name).to eq('Sorbonne 12')
          expect(i.addresses.last.address_1).to eq('1 rue des écoles')
          expect(i.addresses.last.address_2).to eq('')
          expect(i.addresses.last.zip_code).to eq('75005')
          expect(i.addresses.last.city).to eq('Paris')
          expect(i.addresses.last.country).to eq('France')
          expect(i.addresses.last.phone).to eq('0101010101')
          expect(i.addresses.last.latitude).to eq(48.847408)
          expect(i.addresses.last.longitude).to eq(2.352397)
          expect(i.addresses.last.status).to eq('active')
          expect(i.addresses.last.city_code).to eq(111)
          expect(i.addresses.first.status).to eq('archived')
        end
      end

      context 'when archived params' do
        it 'creates an archived name and does not set active others to archived' do
          i = create(:institution)
          archived_address = create(:address, addressable: i, status: 'archived')

          params = {
            address: {
              business_name: 'Sorbonne 12',
              address_1: '1 rue des écoles',
              address_2: '',
              zip_code: '75005',
              city: 'Paris',
              country: 'France',
              phone: '0101010101',
              latitude: 2.00,
              longitude: 4.00,
              status: 'archived',
              city_code: 111
            }
          }

          post "api/institutions/#{i.id}/addresses", params.merge(format: 'json')

          i.reload
          expect(last_response.status).to eq(200)
          expect(i.addresses.count).to eq(3)
          expect(i.addresses.last.business_name).to eq('Sorbonne 12')
          expect(i.addresses.last.address_1).to eq('1 rue des écoles')
          expect(i.addresses.last.address_2).to eq('')
          expect(i.addresses.last.zip_code).to eq('75005')
          expect(i.addresses.last.city).to eq('Paris')
          expect(i.addresses.last.country).to eq('France')
          expect(i.addresses.last.phone).to eq('0101010101')
          expect(i.addresses.last.latitude).to eq(48.847408)
          expect(i.addresses.last.longitude).to eq(2.352397)
          expect(i.addresses.last.status).to eq('archived')
          expect(i.addresses.last.city_code).to eq(111)
          expect(archived_address.reload.status).to eq('archived')
          expect(i.addresses.first.status).to eq('active')
        end
      end
    end

    context 'when params are not valid' do
      it 'creates an active address and sets others to archived' do
        i = create(:institution)

        params = {
          address: {
            business_name: 'S'
          }
        }

        post "api/institutions/#{i.id}/addresses", params.merge(format: 'json')

        i.reload
        expect(last_response.status).to eq(404)
        expect(json_response).to eq("Address 1 can't be blank, Address 1 is too short (minimum is 2 characters), Zip code can't be blank, Zip code is too short (minimum is 2 characters), City can't be blank, City is too short (minimum is 2 characters), Country can't be blank, Country is too short (minimum is 2 characters)")
      end
    end
  end

  describe '#index' do
    it 'returns all addresses' do
      i = create(:institution)
      create(:address, addressable: i)
      create(:address, addressable: i)

      get "api/institutions/#{i.id}/addresses", format: :json
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body).count).to eq(3)
    end
  end

  describe '#update' do
    context 'when address changes' do
      it 'updates a name and coordinates' do
        address = create(:address)

        params = {
            address: {
                business_name: 'Sorbonne 12',
                address_1: '1 rue des écoles',
                address_2: '',
                zip_code: '75005',
                city: 'Paris',
                country: 'France',
                phone: '0101010101',
                latitude: 2.00,
                longitude: 4.00,
                city_code: 111
            }
        }

        put "api/addresses/#{address.id}", params.merge(format: 'json')

        address.reload
        expect(last_response.status).to eq(200)
        expect(address.business_name).to eq('Sorbonne 12')
        expect(address.address_1).to eq('1 rue des écoles')
        expect(address.address_2).to eq('')
        expect(address.zip_code).to eq('75005')
        expect(address.city).to eq('Paris')
        expect(address.country).to eq('France')
        expect(address.phone).to eq('0101010101')
        expect(address.latitude).to eq(48.847408)
        expect(address.longitude).to eq(2.352397)
        expect(address.city_code).to eq(111)
      end
    end

    context 'when address does not change' do
      it 'only updates a name' do
        address = create(:address)
        address.update_columns(latitude: 2.00, longitude: 4.00)

        params = {
          address: {
            business_name: 'Sorbonne 12'
          }
        }

        put "api/addresses/#{address.id}", params.merge(format: 'json')

        address.reload
        expect(last_response.status).to eq(200)
        expect(address.business_name).to eq('Sorbonne 12')
        expect(address.latitude).to eq(2.00)
        expect(address.longitude).to eq(4.00)
      end
    end

  end

  describe '#delete' do
    it 'deletes a name' do
      address = create(:address)
      expect {
        delete "api/addresses/#{address.id}"
      }.to change(Address, :count).by(-1)
    end
  end

  describe '#import' do
    context 'when the file is valid' do
      it 'creates 4 new addresses' do
        DatabaseCleaner.clean_with :truncation
        file = Rack::Test::UploadedFile.new (fixture_path + '/addresses.csv'), 'text/csv'
        create(:institution)

        post 'api/addresses/import', file: file

        expect(last_response.status).to eq(200)
        expect(Address.count).to eq(5)
        expect(Address.last.business_name).to eq('Sorbonne 4')
      end
    end

    context 'when the file is invalid' do
      it 'creates 0 new addresses and returns an error' do
        DatabaseCleaner.clean_with :truncation
        file = Rack::Test::UploadedFile.new (fixture_path + '/wrong_addresses.csv'), 'text/csv'
        create(:institution)

        post 'api/addresses/import', file: file

        expect(last_response.status).to eq(401)
        expect(json_response[:message]).to eq("Ligne 4: Address 1 can't be blank, Address 1 is too short (minimum is 2 characters)")
        expect(Address.count).to eq(1)
      end
    end
  end
end
