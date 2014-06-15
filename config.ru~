# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

if Rails.env.development?
  use Rack::RubyProf, :path => '/temp/profile'
end
