class Messages
  def self.user_created
    'User created and logged in'
  end

  def self.user_not_created
    'Error creating user'
  end

  def self.user_logged_in
    'Successfully logged in'
  end

  def self.user_not_logged_in
    'Log in email or password incorrect'
  end

  def self.user_logged_out
    'Successfully logged out'
  end

  def self.missing_token
    'Missing authorization token in header'
  end

  def self.expired_token
    'Expired authorization token'
  end

  def self.user_not_found
    'User was not found'
  end

  def self.invalid_token
    'Invalid authorization token'
  end

  def self.resource_not_found(resource)
    "Specified #{resource} was not found"
  end

  def self.resource_deleted(resource)
    "#{resource} successfully deleted"
  end
end
