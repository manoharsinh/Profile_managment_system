class NormalUserSessionController < ApplicationController
	def loginform
	end
	def login
		#render json: {msg: params}
  		user=nil
		if params[:normal_user_session][:credentials]=='email'
  			user = Normaluser.find_by(email: params[:normal_user_session][:credentials_type].downcase)
  		elsif params[:normal_user_session][:credentials]=='phonenumber'
  			user = Normaluser.find_by(phonenumber: params[:normal_user_session][:credentials_type])
  		end

	  	#render json: user
	  	if user!=nil
	  		if (user.authenticate(params[:normal_user_session][:password]) && user.status=="active")
	  			session[:user_id]=user.id
	  			redirect_to controller: 'normal_user', action: 'show', id: user.id
	  			#render json: {msg: session}
	  		else
	  			#render json: {msg: params}
	  			render plain: {msg:"Not Authorized to access this page"}
	  		end

	  	else
	  		#render json: {msg: params}
	  		render plain: {msg: "Not Authorized to access this page"}
	  	
	  	end
  	end
  	def logout
	  	session.delete(:user_id)
	  	@current_user=nil
	  	redirect_to :controller => 'normal_user_session', :action => 'new' 
  	end

end
