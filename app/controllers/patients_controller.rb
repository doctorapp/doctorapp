class PatientsController < ApplicationController

	before_filter :admin_user, only: [:destroy]
	before_filter :signed_in_sign_up, only:[:new, :create]
	before_filter :signed_in_user, only: [:edit, :upadte, :show, :index] 
	before_filter :correct_user, only: [:edit, :update]



	def index
		@patients = Patient.paginate(page: params[:page])
	end

  def new
		@patient = Patient.new
  end

	def create
		@patient = Patient.new(params[:patient])
		if @patient.save
			UserMailer.welcome_email(@patient).deliver
			sign_in @patient
			flash[:success] = "Welcome to GSAD!"
			redirect_to @patient
		else
			render 'new'
		end
	end

	def edit
		@patient = Patient.find(params[:id])
	end

	def update
		@patient = Patient.find(params[:id])
		if @patient.update_attributes(params[:patient])
			sign_in @patient
			flash[:success] = "Successfully updated profile!"
			redirect_to @patient
		else
			render 'edit'
		end
	end

	def show
		@patient = Patient.find(params[:id])
		@doctors = @patient.doctors.paginate(page: params[:page])
	end

	def destroy
		Patient.find(params[:id]).destroy
		flash[:success] = "Patient deleted!"
		redirect_to patients_path
	end

	def favorite_doctors
		@title = "Favorite doctors"
		@patient = Patient.find(params[:id])
		@doctors = @patient.doctors.paginate(page: params[:page])
		render 'show'
	end

end
