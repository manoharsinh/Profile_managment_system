class ApplicationController < ActionController::Base
	
	def authorized
		redirect_to '/loginformadmin' unless logged_in?
	end

	def logged_in?
		!current_user.nil? 
	end
	
	def current_user
    	@current_user ||= Admin.find_by(id: session[:admin_id])
    end

    def authorize

    	if logged_in?
    		return
    	elsif logged_in2?
    		return
    	end
    	#redirect_to '/welcome' 
    	render json:"you are not logged in" 
    	
    	
	end

	def logged_in2?
		!current_user2.nil? 
	end

	def current_user2
		@current_user2 ||= Normaluser.find_by(id: session[:user_id])
	end	
end
