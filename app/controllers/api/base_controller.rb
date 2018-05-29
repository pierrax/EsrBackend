class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request
  include Paginator

  class Responder < ActionController::Responder
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
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable

  def not_found
    return api_error(status: 404, errors: 'Record not found')
  end

  def unprocessable(exception)
    return api_error(status: 404, errors: exception.record.errors.full_messages.join(', '))
  end

  def not_saved
    return api_error(status: 404, errors: 'Not saved')
  end

  def unauthorized!(message = t('errors.not_authorized'))
    render json: { error: message }, status: 403
  end

  def try_authenticate
    authenticate if request.headers['HTTP_AUTHORIZATION']
  end

  def catch_404
    return api_error(status: 404, errors: 'Url not found')
  end

  private
  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: errors.to_json, status: status
  end

  def authenticate_request
    @response_code = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @response_code == 200
  end
end
