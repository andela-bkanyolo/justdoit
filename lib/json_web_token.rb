class JsonWebToken
  def self.encode(payload, expiry_date = 24.hours.from_now)
    payload[:expiry_date] = expiry_date.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature => e
    
  end
end
