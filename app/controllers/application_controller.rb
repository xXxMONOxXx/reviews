class ApplicationController < ActionController::Base
	before_action :set_theme

	def set_theme
  		if params[:theme].present?
    		theme = params[:theme].to_sym
    		cookies[:theme] = theme
    		redirect_to(request.referrer || root_path)
  		end
	end
	
	before_action :configure_permitted_parameters, if: :devise_controller?

  	protected
	
	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  	end

  	def favorite_text
  		return @favorite_exists ? 'Unlike' : 'Like'
  	end

  	helper_method :favorite_text
end
