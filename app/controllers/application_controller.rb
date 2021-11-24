class ApplicationController < ActionController::Base
	before_action :set_theme

	def set_theme
  		if params[:theme].present?
    		theme = params[:theme].to_sym
    		cookies[:theme] = theme
    		redirect_to(request.referrer || root_path)
  		end
	end
end
