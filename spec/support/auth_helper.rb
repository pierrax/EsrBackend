module AuthHelper
  def api_logged_in_as_user(user = nil, password = nil)
    password ||= 'very_secret_password'
    user ||= create(:user, password: password, password_confirmation: password)
    login_params = {email: user.email, password: password}
    post api_login_path, login_params
    expect(last_response.try(:status)).to eq(200)

    auth_header = "Bearer #{JSON.parse(last_response.try(:body))['access_token']}"
    header('Authorization', auth_header)
    user
  end

  def app
    Rails.application
  end
end
