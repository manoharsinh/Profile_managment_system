class UpdateHeights < ActiveRecord::Migration[6.0]
    def change
  		Normaluser.find_each do |user|
  			if user.height == nil
      			user.height = 0
  
      			user.save!
    		end
  		end
  	end
end
