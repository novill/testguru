class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :add_devise_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { lang: I18n.locale }
  end

  private

    def set_locale
      I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
    end

    def after_sign_in_path_for(user)
      flash[:notice] = t('hello', name: user.name)
      user.admin? ? admin_tests_path : root_path
    end

    def add_devise_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
