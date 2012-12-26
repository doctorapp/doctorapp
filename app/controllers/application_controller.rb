class ApplicationController < ActionController::Base
  protect_from_forgery
	include SessionsHelper  # make the module SessionHelper available in Controllers; it is automatically available in views/session

	before_filter :signed_in_user, only: [:edit, :upadte, :show, :index] 
	before_filter :correct_user, only: [:edit, :update]
	before_filter :signed_in_sign_up, only:[:new, :create]

end

