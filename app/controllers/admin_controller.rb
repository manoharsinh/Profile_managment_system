class AdminController < ApplicationController
	before_action :authorized, except: [:welcome]
	def welcome
	end
	def searchbar
	end
	
	def search_result
		
	end

	
	def search
    	
		#@users = Normaluser.search(params[:normal_user][:term]).records
    	@users=Normaluser.search(
    		{
			  query: {
			    multi_match: {
			      query:    "#{params[:normal_user][:term]}",
			      #type:       "phrase_prefix",
			      fields: [ 'email', 'name','phonenumber' ]
			    }
			  }
			}
		)
		if(@users.first==nil)
		 	render plain:{msg:"search is empty"}
		end
  	end
  	def dday

  	end
  	def getreport
  		data = File.read("/home/manoharsinhrana/Blog11/daily_user_report3.txt")
  		@words=data.split(":")

  	end
end
