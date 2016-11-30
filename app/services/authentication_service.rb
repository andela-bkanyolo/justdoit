class AuthenticationService
  def initialize(user_details)
    @user_details = user_details
  end

  def create_user
    user = User.create!(@user_details)
    JsonWebToken.encode(user_id: user.id)
  rescue ActiveRecord::RecordInvalid
    raise
  end

  def login
  end

  def logout
  end
end
