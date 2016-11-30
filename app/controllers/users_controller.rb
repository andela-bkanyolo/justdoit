class UsersController < ApplicationController

  def create
    data = {
      message: Messages.user_created,
      auth_token: authentication_service.create_user
    }
    render_json(data, :created)
  end

  private

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def authentication_service
    AuthenticationService.new(user_params)
  end
end
