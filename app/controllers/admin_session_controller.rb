class AdminSessionController < ApplicationController
	skip_before_action :verify_authenticity_token
	def loginform
	end
	def login
		#render json: params
		user=nil
		if params[:admin_session][:credentials]=='email'
  			user = Admin.find_by(email: params[:admin_session][:credentials_type].downcase)
  		elsif params[:admin_session][:credentials]=='phonenumber'
  			user = Admin.find_by(phonenumber: params[:admin_session][:credentials_type].downcase)
  		end

	  	if user!=nil
	  		if user.authenticate(params[:admin_session][:password])
	  			#render json:{msg: session}
	  	 		session[:admin_id]=user.id
	  	 		#render json:{msg:"you have logged in"}
	  	 		
	  	 		redirect_to :controller => 'admin', :action => 'dday'
	  	 	else
	  	 		flash[:alert] = "Not Authorized to access this page"
	  	 	end

	  	else
	  	 	flash[:alert] = "Not Authorized to access this page"
	  	end
  	end
  	def logout
	  	session.delete(:admin_id)
	  	@current_user=nil
	  	redirect_to :controller => 'admin_session', :action => 'loginform' 
  	end

end
