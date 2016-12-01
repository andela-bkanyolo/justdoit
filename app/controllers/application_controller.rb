class ApplicationController < ActionController::API
  include JsonResponse
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user, :token

  private

  def authorize_request
    authorized = AuthorizationService.new(request.headers).authorize
    @current_user = authorized[:user]
    @token = authorized[:token]

    unless @current_user.tokens.pluck(:token).include? @token
      raise(ExceptionHandler::NotAuthorized, Messages.expired_token)
    end
  end
end
