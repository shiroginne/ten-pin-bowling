class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::UnknownFormat, with: :unsupported_format

  private
    def render_404(exception = nil)
      logger.debug "Rendering 404: #{exception.message}" if exception
      render "shared/404", status: 404
    end

    def unsupported_format(exception = nil)
      logger.debug "Rendering 404: #{exception.message}" if exception
      render plain: I18n.t("unsupported_format"), status: 415, layout: false
    end
end
