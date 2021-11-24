class ApplicationController < ActionController::Base
	before_action :set_theme

	def set_theme
  		if params[:theme].present?
    		theme = params[:theme].to_sym
    		cookies[:theme] = theme
    		redirect_to(request.referrer || root_path)
  		end
	end

	def configure_permitted_parameters
		added_attrs = [:username, :email, :password, :password_confirmation, :remeber_me]
		devise_parameter_sanitaser.permit :sign_up, keys: added_attrs
		devise_parameter_sanitaser.permit :accout_update, keys: added_attrs

	end
end
