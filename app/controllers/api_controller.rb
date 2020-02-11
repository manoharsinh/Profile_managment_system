class ApiController < ApplicationController
	def getprofile
		user=Normaluser.find(params[:id])
		render json: {msg: user}
	end 
	def signup
		#render json: {msg:params}
		@user=Normaluser.new(user_params)
		if @user.save

			render json: {msg:@user}
		else
			render json:{msg:"could not insert data"}
		end

	end
	def login
		user = Normaluser.find_by(email: params[:email].downcase)
	  	if user!=nil
	  		if user.authenticate(params[:password])
	  			session[:user_id]=user.id
	  			render json:{msg: "logged in"}
	  			#redirect_to :controller => 'admin', :action => 'dday'
	  		else
	  			render json:{msg: "could not log in"}
	  			#flash[:alert] = "Not Authorized to access this page"
	  		end

	  	else
	  		render json:{msg: "could not log in"}
	  		#flash[:alert] = "Not Authorized to access this page"
	  	end
	end
	private
	def user_params
		params.permit(:name, :password,:email,:accounttype,:phonenumber,:status,:pid)
	end
end
