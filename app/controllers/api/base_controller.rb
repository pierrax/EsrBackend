class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request
  attr_reader :current_user

  class Responder < ActionController::Responder
    # simply render the resource even on POST instead of redirecting for ajax
    def api_behavior
      if post? || put? || delete?
        display resource, status: :ok
      else
        super
      end
    end
  end

  protect_from_forgery with: :null_session

  self.responder = Responder
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    return api_error(status: 404, errors: 'Record not found')
  end

  def unauthorized!(message = t('errors.not_authorized'))
    render json: { error: message }, status: 403
  end

  def try_authenticate
    authenticate if request.headers['HTTP_AUTHORIZATION']
  end

  private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      user = User.find_by_auth_token(token)
      return unauthorized! unless user && user.active
      sign_in(user, store: false)
    end
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: errors.to_json, status: status
  end

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
