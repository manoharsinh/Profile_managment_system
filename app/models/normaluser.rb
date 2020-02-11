require 'elasticsearch/model'

class Normaluser < ApplicationRecord
	has_secure_password
	#validates :email, presence: true, uniqueness: true
	ACCOUNT_OPTIONS = %w(broker owner buyer)
	STATUS_OPTIONS = %W(active inactive)
	#validates :phonenumber,:presence => true,
     #             :numericality => true,
     #             :length => { :minimum => 10, :maximum => 10 }
   	#validates :accounttype, :inclusion => {:in => ACCOUNT_OPTIONS}
   	#validates :status, :inclusion => {:in => STATUS_OPTIONS}
	include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
	#validate :pid_check_on_create, :on => :create
	#validate :pid_check_on_update, :on => :update
	validate :check_on_update, :on => :update
	validate :check_on_update, :on => :create
	
	private
	def check_on_update
		if is_cyclic?
			puts "hierarchy is cyclic"
			errors.add(:pid,'it is cyclic')
			return
		
		elsif(get_height(id)+getDepth >= 3)
			puts "height limit exceeded"
			errors.add(:pid,'height limit exceeded')
			return
		elsif count_children >= 4
			errors.add(:pid,'children limit exceeded')
			return
		end
		puts "all is fine at update"
	end
	def is_cyclic?
		puts "I am in cyclic 5#{pid}"
		if pid==nil || id==nil

			return false
		end
		if id==pid
			puts "parent is child"
			return true
		end
		puts "I am after first if"
		ppid=Normaluser.find(pid).pid
		if(ppid==nil)
			puts "yes ppid is null"
			return false
		end
		if id==ppid
			puts "parent is grandchild"
			return true
		end
		puts "I am after second if"
		pppid=Normaluser.find(ppid).pid
		if pppid==nil
			puts "yes pppid is nil"
			return false
		end
		if id==pppid
			puts "parent is grand grand child"
			return true
		end
		puts "not cyclic"
		return false
	end

	
	
	def count_children
		return Normaluser.where("pid= ? ",pid).count
	end
	def get_height(curr_id)
		if curr_id==nil
			return 0
		end
  		maxHeight=0
  		Normaluser.where(pid: curr_id).each do |f|
  			tempHeight=get_height(f.id)
  			if tempHeight+1 > maxHeight
  				maxHeight=tempHeight+1
  			end 	
  		end
  		puts "#{curr_id} height #{maxHeight}"
  		return maxHeight

  	end
	def getDepth
		depth=0
		temp_pid=pid
		while temp_pid!=nil
			depth=depth+1
			temp_pid=Normaluser.find(temp_pid).pid
		end
		puts "#{pid} depth #{depth}"
		return depth
	end
	# def pid_check_on_create
	# 	height=0
	# 	does_height_exceed=false
	# 	if(pid != nil)
	# 		ppid = Normaluser.find(pid).pid
	# 		if(ppid != nil)
	# 			pppid = Normaluser.find(ppid).pid
	# 			if(pppid != nil)
	# 				does_height_exceed = true
	# 			end

	# 		end
	# 	end

	# 	height=0
	# 	children_count_for_pid=Normaluser.where("pid= ? ",pid).count
	# 	puts "count is this #{children_count_for_pid}"
	# 	if ((children_count_for_pid >= 4 && pid!=nil) || (does_height_exceed)) || is_cyclic?
	# 		puts "im in if loop#{does_height_exceed}"
	# 		errors.add(:pid,'pid exceeded validations')
	# 	else
	# 		puts "no error"
	# 		temp_pid=pid
	# 		puts "here is #{temp_pid}"
	# 		temp_height=0
	# 		while(temp_pid!=nil) do 
	# 			puts "I am here"
	# 			temp_height=temp_height+1
	# 			record=Normaluser.find(temp_pid)
	# 			temp_pid=record.pid
	# 			if record.height == nil
	# 				record.update(height: 0)

	# 			end
	# 			if record.height < temp_height
	# 				record.update(height: temp_height)

	# 			else
	# 				break
	# 			end

	# 		end
			
			
	# 	end 
	# end

	# def pid_check_on_update
	# 	puts "hello stranger"
	# 	if is_cyclic?
	# 		errors.add(:pid ,'It is cyclic')
	# 		return
	# 	end
	# 	temp_pid = pid
	# 	temp_depth = 0
	# 	while(temp_pid != nil) do 
	# 		temp_depth = temp_depth+1
	# 		temp_pid = Normaluser.find(temp_pid).pid
	# 	end

	# 	if(height+temp_depth>=2)
	# 		errors.add(:pid,'pid height exceeded')
	# 	else
	# 		temp_pid=pid
	# 		puts "here is #{temp_pid}"
	# 		temp_height=height
	# 		while(temp_pid!=nil) do 
	# 			puts "I am here"
	# 			temp_height=temp_height+1
	# 			record=Normaluser.find(temp_pid)
	# 			temp_pid=record.pid
	# 			if record.height == nil
	# 				record.update(height: 0)

	# 			end
	# 			if record.height < temp_height
	# 				record.update(height: temp_height)

	# 			else
	# 				break
	# 			end

	# 		end
	# 	end

	# end


end
