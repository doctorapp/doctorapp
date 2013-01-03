class ApplicationController < ActionController::Base
  protect_from_forgery
	include SessionsHelper  # make the module SessionHelper available in Controllers; it is automatically available in views/session

<<<<<<< HEAD
	before_filter :signed_in_user, only: [:edit, :upadte, :show, :index] 
	#before_filter :correct_user, only: [:edit, :update]

	end
=======
end
>>>>>>> 1191ca3c380d54cdee90bd2cad3c7c0b08d23f98

