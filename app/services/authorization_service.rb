class AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  def authorize
    { user: user, token: http_auth_header }
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound
    raise(ExceptionHandler::UserNotFound, Messages.user_not_found)
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    valid_headers = headers.fetch("Authorization")
    return valid_headers.split(" ").last
  rescue KeyError, NameError
    raise(ExceptionHandler::NotAuthorized, Messages.missing_token)
  end
end
