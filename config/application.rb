require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Darekatohanasu
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/lib/validators #{config.root}/app/workers #{config.root}/app/model/concerns)
  end
end
