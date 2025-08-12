class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from ActiveRecord::RecordNotFound, with: :render_app_404
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def render_app_404
      respond_to do |format|
        format.html { head :not_found }
        format.json { render json: { error: "Not Found" }, status: :not_found }
        format.any { head :not_found }
      end
  end

  private

 # Custom method to handle unauthorized access
 def user_not_authorized(exception)
  # Log the error for debugging purposes (optional)
  Rails.logger.error "Unauthorized access attempt: #{exception.message}"

  # Render the unauthorized template
  render "errors/unauthorized", status: :forbidden
  end
end
