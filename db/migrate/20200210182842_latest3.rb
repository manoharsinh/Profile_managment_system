class Latest3 < ActiveRecord::Migration[6.0]
 def change
  	i = 0
	loop do
  		i += 1
  		puts i
  		record=Normaluser.find(i)
  		record.height=get_height(record)
  		record.save!
  		if i == 39
    		break       # this will cause execution to exit the loop
  		end
	end
  end
  def get_height(record)
  	maxHeight=0
  	Normaluser.where(pid: record.id).each do |f|
  		tempHeight=get_height(f)
  		if tempHeight+1 > maxHeight
  			maxHeight=tempHeight+1
  		end 	
  	end
  	return maxHeight
  end
end
