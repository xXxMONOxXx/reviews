class ApplicationController < ActionController::Base
	before_action :set_theme

	def set_theme
  		if params[:theme].present?
    		theme = params[:theme].to_sym
    		cookies[:theme] = theme
    		redirect_to(request.referrer || root_path)
  		end
	end

	before_action :set_locale

  	private

  	def default_url_options
    	{locale: I18n.locale}
  	end

  	def set_locale
    	I18n.locale = extract_locale || I18n.default_locale
  	end

  	def extract_locale
    	parsed_locale = params[:locale]
    	I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
      	parsed_locale.to_sym :
      	nil
  	end
	
	before_action :configure_permitted_parameters, if: :devise_controller?

  	protected
	
	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  	end

  	def favorite_text
  		return @favorite_exists ? t('liked_page.unlike') : t('liked_page.like')
  	end

  	helper_method :favorite_text
end
