class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception
  helper_method :formatar_data

  def set_locale
    I18n.locale = 'pt'
  end

  def formatar_data(data)
    data.strftime("%d/%m/%Y %H:%M")
  end
end




