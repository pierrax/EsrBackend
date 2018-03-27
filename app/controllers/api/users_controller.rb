class Api::UsersController < Api::BaseController
  # before_action :authenticate, except: :create
  skip_before_action :authenticate_request, only: %i[login register]

  def index
    @user = User.all
    respond_with @users
  end

  # POST /register
  def register
    @user = User.new(user_params)
    p @user
    if @user.save
      response = { message: 'User created successfully'}
      render json: response
    else
      render json: @user.errors
    end
  end

  def login
    authenticate params[:email], params[:password]
  end

  def test
    render json: {
               message: 'You have passed authentication and authorization test'
           }
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :first_name,
      :last_name
    )
  end

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
                 access_token: command.result,
                 message: 'Login Successful'
             }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
