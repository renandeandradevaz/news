class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = 'pt'
  end
end
