module ExceptionHandler
  extend ActiveSupport::Concern

  class ExpiredSignatureError < StandardError; end

  included do
    rescue_from ExceptionHandler::ExpiredSignatureError, with: :access_denied

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_json({ errors: e.message }, :unprocessable_entity)
    end

    rescue_from ActiveModel::UnknownAttributeError do |e|
      render_json({ errors: e.message }, :unprocessable_entity)
    end
  end

  private

  def access_denied(e)
    render_json({ errors: e.message }, :unauthorized)
  end
end
