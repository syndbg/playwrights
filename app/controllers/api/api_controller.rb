module Api
  class ApiController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

    after_action :set_csrf_cookie!

    respond_to :json

    private

    def set_csrf_cookie!
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    end

    # Override
    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end
  end
end
