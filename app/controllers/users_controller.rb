class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Messages.user_created, auth_token: auth_token }
      render_json(response, :created)
    else
      render_json(
        { message: Messages.user_not_created },
        :unprocessable_entity
      )
    end
  end

  private

  def user_params
    params.permit(
      :firstname,
      :lastname,
      :email,
      :password,
      :password_confirmation
    )
  end
end
