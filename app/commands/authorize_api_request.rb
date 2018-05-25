class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    response = HTTParty.post(ENV['CHECK_TOKEN_URL'], headers: { Authorization:  "Bearer #{http_auth_header}"} )
    response.code
  end

  private

  def http_auth_header
    if @headers['Authorization'].present?
      return @headers['Authorization'].split(' ').last
    else errors.add(:token, 'Missing token')
    end
    nil
  end
end
