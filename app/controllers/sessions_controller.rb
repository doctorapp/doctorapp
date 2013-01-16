class SessionsController < ApplicationController
	
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			if params[:remember_me]
				sign_in_and_remember(user)
			else
				sign_in(user)
			end
			flash[:success] = "Successfully signed in as #{user.type}!"
			redirect_back_or root_path
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

end
