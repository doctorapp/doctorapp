module SessionsHelper
  
	def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
 
  def signed_in?
    !current_user.nil?
  end
 
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

	def admin?
		current_user.type == 'Admin'
	end

	def patient?
		current_user.type == 'Patient' 
	end

	def doctor?
		current_user.type == 'Doctor'
	end

  def current_user=(user)
    @current_user = user
  end

  def current_user
#		user = User.find_by_remember_token(cooies[:remember_token])
#		if user.type = 'Patient'
#			@current_user ||= Patient.find_by_remember_token(cookies[:remember_token])
#		elsif user.type = 'Doctor'
#			@current_user ||= Doctor.find_by_remember_token(cookies[:remember_token])
#		elsif user.type = 'Admin'
#			@current_user ||= Admin.find_by_remember_token(cookies[:remember_token])
#		else
#			@current_user = user
#		end

    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == @current_user
  end
 
	def current_patient=(patient)
		@current_patient = patient
	end

	def current_patient
		@current_patient ||= Patient.find_by_remember_token(cookies[:remember_token])
	end

	def correct_user
		@user = User.find(params[:id])
		logger.debug "user: #{@user.email}"
		logger.debug "current_user: #{current_user.email}"
		unless current_user?(@user)
			flash[:notice] = "Not authorized to do it!"
			redirect_to root_path
		end
	end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

	def signed_in_sign_up
		if signed_in?
			flash[:warning] = "You already have an account!"
			redirect_to root_path
		end
	end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
 
end
