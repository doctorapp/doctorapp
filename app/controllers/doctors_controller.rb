class DoctorsController < ApplicationController

# before_filter :signed_in_user, only: [:edit, :update, :show, :index]
#	before_filter :correct_user, only: [:edit, :update]A
	before_filter :admin_user, only: [:destroy]

	def index
		@doctors = Doctor.paginate(page: params[:page])
	end

	def new 
		@doctor = Doctor.new
	end

	def create
		@doctor = Doctor.new(params[:doctor])
		if @doctor.save
		 	sign_in @doctor
			flash[:success] = "Welcome to g-s-a-d!"
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
		Doctor.find(params[:id]).destory
		flash[:success] = "Doctor deleted!"
		redirect_to doctors_path
	end

end
