module Client
  class BaseController < BaseController
    before_action :authenticate_user!
    before_action :authorize_client_access

    private

    def authorize_management_access
      authorize :client_access, :access?
    end
  end
end
