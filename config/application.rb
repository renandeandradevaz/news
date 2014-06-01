require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module News
  class Application < Rails::Application
    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :local
  end
end
