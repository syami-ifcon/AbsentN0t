class HomeController < ApplicationController
 
 	def index
 		if current_user
 			if current_user.roles == "teacher"
 				# byebug
 				return lectures_path
 			else
 				return admin_path
 			end
 		else
 			return root_path
 		end
 	end

end
