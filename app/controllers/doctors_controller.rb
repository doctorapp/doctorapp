class DoctorsController < ApplicationController

# before_filter :signed_in_user, only: [:edit, :update, :show, :index]
#	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: [:destroy]
	before_filter :signed_in_sign_up, only:[:new, :create]
	before_filter :signed_in_user, only: [:edit, :upadte, :show, :index] 
	before_filter :correct_user, only: [:edit, :update]
	before_filter :office_user, only: [:managed]

	def index
		@doctors = Doctor.search_by_name(params[:search]).paginate(page: params[:page], per_page: 20)
	end

	def new 
		@doctor = Doctor.new
	end

	def create
		@doctor = Doctor.new(params[:doctor])
		if @doctor.save
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
		if @doctor.update_attributes(params[:doctor])
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
		Doctor.find(params[:id]).destroy
		flash[:success] = "Doctor deleted!"
		redirect_to doctors_path
	end

end
