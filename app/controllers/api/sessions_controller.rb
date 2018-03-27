class Api::SessionsController < Api::BaseController
  before_action :authenticate, except: :create

  def create
    @user = User.facebook_login(params[:facebook_uid], params[:facebook_token], device_token: params[:device_token])

    if @user && @user.valid?
      sign_in @user, store: false
      respond_with @user
    else
      head :unauthorized
    end
  end

  def destroy
    user = current_user
    sign_out current_user
    respond_with user
  end
end
