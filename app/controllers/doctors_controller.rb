class DoctorsController < ApplicationController

# before_filter :signed_in_user, only: [:edit, :update, :show, :index]
#	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: [:destroy]
	before_filter :signed_in_sign_up, only:[:new, :create]
	before_filter :signed_in_user, only: [:edit, :upadte, :show, :index] 
	before_filter :correct_user, only: [:edit, :update]



	def index
		@doctors = Doctor.paginate(page: params[:page])
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
			doctor.work_days.monday 		= params[:monday]
			doctor.work_days.tuesday 		= params[:tuesday]
			doctor.work_days.wednesday	= params[:wednesday]
			doctor.work_days.thursday 	= params[:thursday]
			doctor.work_days.friday 		= params[:friday]
			doctor.work_days.saturday		= params[:saturday]
			doctor.work_days.sunday 		= params[:sunday]
		end

end
