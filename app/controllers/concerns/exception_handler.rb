module ExceptionHandler
  extend ActiveSupport::Concern

  class ExpiredSignature < StandardError; end
  class AccessDenied < StandardError; end

  included do
    rescue_from ExceptionHandler::ExpiredSignature, with: :access_denied
    rescue_from ExceptionHandler::AccessDenied, with: :access_denied

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_json({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActiveModel::UnknownAttributeError do |e|
      render_json({ message: e.message }, :unprocessable_entity)
    end
  end

  private

  def access_denied(e)
    render_json({ message: e.message }, :unauthorized)
  end
end
