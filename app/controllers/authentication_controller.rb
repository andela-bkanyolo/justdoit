class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :login

  def login
    data = {
      message: Messages.user_logged_in,
      auth_token: authentication_service.login.token
    }
    render_json(data)
  end

  def logout
    authentication_service.logout(token)
    data = { message: Messages.user_logged_out }
    render_json(data)
  end

  private

  def authentication_service
    AuthenticationService.new(params)
  end
end
