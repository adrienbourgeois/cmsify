require "cmsify/engine"
require "cmsify/helpers"
require 'paperclip'

module Cmsify
  def self.configuration
    @configuration ||= Struct.new('Configuration',
      :s3_credentials_yaml,
      :s3_host_name,
      :can_update,
    ).new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end
