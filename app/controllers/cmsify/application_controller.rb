module Cmsify
  class ApplicationController < ActionController::Base
    before_filter :authorize_user, except: [:show]

    private
    def authorize_user
      head :unauthorized unless ::Cmsify.configuration.can_update && ::Cmsify.configuration.can_update.call(request)
    end
  end
end
