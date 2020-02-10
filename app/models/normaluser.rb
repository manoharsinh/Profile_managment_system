require 'elasticsearch/model'

class Normaluser < ApplicationRecord
	has_secure_password
	validates :email, presence: true, uniqueness: true
	ACCOUNT_OPTIONS = %w(broker owner buyer)
	STATUS_OPTIONS = %W(active inactive)
	validates :phonenumber,:presence => true,
                  :numericality => true,
                  :length => { :minimum => 10, :maximum => 10 }
   	validates :accounttype, :inclusion => {:in => ACCOUNT_OPTIONS}
   	validates :status, :inclusion => {:in => STATUS_OPTIONS}
	include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
	validate :pid_check_on_create, :on => :create
	#validate :pid_check_on_update, :on => :update
	
	private

	def pid_check_on_create

		does_height_exceed=false
		if(pid != nil)
			ppid = Normaluser.find(pid).pid
			if(ppid != nil)
				pppid = Normaluser.find(ppid).pid
				if(pppid != nil)
					does_height_exceed = true
				end

			end
		end

		height=0
		children_count_for_pid=Normaluser.where("pid= ? ",pid).count
		puts "count is this #{children_count_for_pid}"
		if ((children_count_for_pid >= 4 && pid!=nil) || (does_height_exceed)) || is_cyclic?
			puts "im in if loop#{does_height_exceed}"
			errors.add(:pid,'pid exceeded validations')
		else
			puts "no error"
			# temp_pid=pid
			# temp_height=0
			# while(temp_pid!=nil) do 
			# 	puts "I am here"
			# 	temp_height=temp_height+1
			# 	record=Normaluser.find(pid)
			# 	temp_pid=record.pid
			# 	if record.height==nil
			# 		record.height=0
			# 	end
			# 	if record.height < temp_height
			# 		record.height = temp_height
			# 	else
			# 		break
			# 	end

			# 	record.save

			
			
		end 
	end

	def pid_check_on_update
		if is_cyclic?
			errors.add(:pid ,'It is cyclic')
			return
		end
		temp_pid = pid
		temp_depth = 0
		while(temp_pid != nil) do 
			temp_depth = temp_depth+1
			temp_pid = Normaluser.find(temp_pid).pid
		end
		if(height+temp_depth>=2)
			errors.add(:pid,'pid height exceeded')

		end

	end

	def is_cyclic?
		puts "I am in cyclic 5#{pid}"
		if pid==nil
			return false
		end

		puts "I am after first if"
		ppid=Normaluser.find(pid).pid
		if(ppid==nil)
			puts "yes pid is null"
			return false
		end
		if id==ppid
			return true
		end
		puts "I am after second if"
		pppid=Normaluser.find(ppid).pid
		if pppid==nil
			return false
		end
		if id==pppid
			return true
		end
		return false
	end
	def is_cyclic_with_params?(current_user)
	end

end
