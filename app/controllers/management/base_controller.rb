module Management
  class BaseController < BaseController
    before_action :authenticate_user!
    before_action :authorize_management_access

    before_action :set_layout_data
    before_action :set_layout_heading

    layout "management"

    private

    def authorize_management_access
      authorize :management_access, :access?

      @current_organization = current_user.organization
      raise "No organization assigned" if @current_organization.nil?

      CurrentOrganization.organization = @current_organization
    end

    def set_layout_data
      @layout_data = {
        heading: ""
      }
    end

    def set_layout_heading
      @layout_data[:heading] = ""
    end

    def set_breadcrumbs_dashboard
      add_breadcrumb management_dashboard_url, "Dashboard"
    end

    def render_stream_notice
      turbo_stream.replace("managementFlashMessages", partial: "layouts/elements/management/flash")
    end

    def flash_message_success(add_message = nil)
      message = (add_message) ? add_message : "Zapisano poprawnie"
      flash[:notice] = "#{message}"
    end

    def flash_message_error(add_message = nil)
      message = (add_message) ? add_message : "Wystąpił problem z zapisem"
      flash[:flash_message_error] = "#{message}"
    end


    def turbo_stream_close_modal_form
      turbo_stream.replace("resourceModalContent", '<turbo-frame id="resourceModalContent"></turbo-frame>')
    end

    def turbo_stream_render_modal_form(partial_form)
      turbo_stream.replace("resourceModalContent", partial: partial_form)
    end

    def turbo_stream_update_main(path = nil, partial: nil, template: nil)
      # Dynamically determine the path if not provided
      path_to_view = path.present? ? path : "#{controller_name}/#{action_name}"

      if partial
        turbo_stream.update("main-content", partial: partial)
      elsif template
        turbo_stream.update("main-content", template: template)
      else
        turbo_stream.update("main-content", template: path_to_view)
      end
    end
  end
end
