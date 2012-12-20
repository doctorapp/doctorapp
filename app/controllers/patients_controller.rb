class PatientsController < ApplicationController

	before_filter :admin_user, only: [destroy]

	def index
		@patients = Patient.paginate(page: params[:page])
	end

  def new
		@patient = Patient.new
  end

	def create
		@patient = Patient.new(params[:patient])
		if @patient.save
			sign_in @patient
			flash[:success] = "Welcome to the g-s-a-d!"
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
		# appointments information
	end

	def destroy
		Patient.find(params[:id]).destroy
		flash[:success] = "Patient deleted!"
		redirect_to doctors_path
	end

end
