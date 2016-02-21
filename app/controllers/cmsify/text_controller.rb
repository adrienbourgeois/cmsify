module Cmsify
  class TextController < ApplicationController
    before_filter :get_text

    def update
      if new_content = params[:content]
        if @object.update_attribute(params[:field], new_content)
          render json: @object
        else
          render json: @object.errors.full_messages, status: :unprocessable_entity
        end
      else
        head :bad_request
      end
    end

    private
    def get_text
      begin
        @object = params[:object_model].constantize.find(params[:id])
      rescue
        head :not_found
      end
    end
  end
end