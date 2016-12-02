class AuthenticationService
  def initialize(user_details)
    @user_details = user_details
  end

  def signup
    user = User.create!(@user_details)
    login(user)
  rescue ActiveRecord::RecordInvalid
    raise
  end

  def login(user = nil)
    user ||= User.find_by(email: @user_details[:email])
    if user && user.authenticate(@user_details[:password])
      user.tokens.destroy_all
      return user.tokens.create(token: JsonWebToken.encode(user_id: user.id))
    else
      raise(ExceptionHandler::AccessDenied, Messages.user_not_logged_in)
    end
  end

  def logout(token)
    Token.find_by(token: token).destroy
  end
end
