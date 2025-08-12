class BaseController < ApplicationController
    include Pagy::Backend
    before_action :add_home_breadcrumb
    helper_method :add_breadcrumb

    def add_breadcrumb(url, label)
        @breadcrumbs ||= []
        @breadcrumbs << [ url, label ]
    end

    private

    def add_home_breadcrumb
        add_breadcrumb root_url, "Bookerhub"
    end
end
