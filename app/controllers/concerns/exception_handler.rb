module ExceptionHandler
  extend ActiveSupport::Concern

  class ExpiredSignature < StandardError; end
  class AccessDenied < StandardError; end
  class NotAuthenticated < StandardError; end
  class UserNotFound < StandardError; end
  class NotAuthorized < StandardError; end

  included do
    rescue_from ExceptionHandler::ExpiredSignature, with: :access_denied
    rescue_from ExceptionHandler::AccessDenied, with: :access_denied
    rescue_from ExceptionHandler::NotAuthorized, with: :access_denied
    rescue_from ExceptionHandler::NotAuthenticated, with: :access_denied
    rescue_from ExceptionHandler::UserNotFound, with: :user_not_found

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_json({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_json({ message: e.message }, :not_found)
    end
  end

  private

  def access_denied(e)
    render_json({ message: e.message }, :unauthorized)
  end

  def user_not_found(e)
    render_json({ errors: e.message }, :not_found)
  end
end
