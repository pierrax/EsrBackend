require 'rails_helper'

RSpec.describe Api::BaseController, :type => :request do
  include Rack::Test::Methods

  before(:each) do
    api_logged_in_as_user
  end

  describe '#catch_404' do
    context 'when wrong url' do
      it 'returns a 404 error' do
        get 'api/xxx', format: :json
        expect(last_response.status).to eq(404)
        expect(json_response).to eq('Url not found')
      end
    end
  end
end
