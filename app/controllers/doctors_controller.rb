class DoctorsController < ApplicationController

# before_filter :signed_in_user, only: [:edit, :update, :show, :index]
#	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: [:destroy]
	before_filter :signed_in_sign_up, only:[:new, :create]
	before_filter :signed_in_user, only: [:edit, :upadte, :show, :index] 
	before_filter :correct_user, only: [:edit, :update]


	def index
		@doctors = Doctor.paginated_search_by_name(params[:search], params[:page])
	end

	def new 
		@doctor = Doctor.new
	end

	def create
		@doctor = Doctor.new(params[:doctor])
		set_work_days(@doctor)
		if @doctor.save && @doctor.work_days.save
		 	sign_in @doctor
			flash[:success] = "Welcome to GSAD!"
			redirect_to @doctor
		else
			render 'new'
		end
	end

	def doctorappointments
		@doctor = Doctor.find(params[:id])
		@appointments = @doctor.appointments

		respond_to do |format|
      		format.html # index.html.erb
      		format.json { render json: @appointments }
    	end
	end

	def edit
		@doctor = Doctor.find(params[:id])
	end

	def update
		params[:doctor][:domain_ids] ||= []
		params[:doctor][:language_ids] ||= []
		@doctor = Doctor.find(params[:id])
		set_work_days(@doctor)
		if @doctor.update_attributes(params[:doctor]) && @doctor.work_days.save
		 	sign_in @doctor
			flash[:success] = "Successfully updated profile!"
			redirect_to @doctor
		else
			render 'edit'
		end
	end

	def show
		@doctor = Doctor.find(params[:id])	
	end

	def destroy
		Doctor.find(params[:id]).destory
		flash[:success] = "Doctor deleted!"
		redirect_to doctors_path
	end

	private 

		def set_work_days(doctor)
			doctor.work_days.monday 		= params[:monday] 		? true : false
			doctor.work_days.tuesday 		= params[:tuesday] 		? true : false
			doctor.work_days.wednesday	= params[:wednesday] 	? true : false
			doctor.work_days.thursday 	= params[:thursday] 	? true : false
			doctor.work_days.friday 		= params[:friday] 		? true : false
			doctor.work_days.saturday		= params[:saturday] 	? true : false
			doctor.work_days.sunday 		= params[:sunday] 		? true : false
		end

end
