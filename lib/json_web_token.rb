class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base).first
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature
    raise(ExceptionHandler::NotAuthorized, Messages.expired_token)
  rescue JWT::VerificationError, JWT::DecodeError
    raise(ExceptionHandler::NotAuthorized, Messages.invalid_token)
  end
end
