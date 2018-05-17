module AuthHelper
  def api_logged_in_as_user
    response = double('response', result: 200)
    allow(AuthorizeApiRequest).to receive(:call).and_return(response)
  end
end
