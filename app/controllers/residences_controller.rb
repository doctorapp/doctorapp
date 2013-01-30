class ResidencesController < ApplicationController

	before_filter :signed_in_user
	before_filter :admin_user, only: [:pending]
	before_filter :office_user, only: [:create, :destroy, :edit, :managed]

	respond_to :html, :js

	def index
		@doctor = Doctor.find(params[:doctor_id])
		@residences = @doctor.residences
		if @residences.size == 1
			redirect_to doctor_residence_url(@doctor, @residences.first)
		end
	end

	def show
		@doctor = Doctor.find(params[:doctor_id])
		@residence = Residence.find(params[:id])
	end
	
	def pending
		@residences = Residence.where(approved: false)
	end

	def managed
		@residences = current_user.residences		
	end

	def create
		@doctor = Doctor.find(params[:residence][:doctor_id])
		current_user.manage!(@doctor)
		respond_with @doctor
	end

	def destroy
		@doctor = Residence.find(params[:id]).doctor
		current_user.unmanage!(@doctor)
		respond_with @doctor
	end

	def edit
		@residence = Residence.find(params[:id])
		@doctor = @residence.doctor
		@vacation = @doctor.vacations.new
	end

	def update
		@residence = Residence.find(params[:id])
		@doctor = @residence.doctor
		@vacation = @doctor.vacations.new
		if current_user.office?
			params[:residence][:office_hour_start] = Time.parse("#{params[:office_hour_start]} UTC")
			params[:residence][:office_hour_end] = Time.parse("#{params[:office_hour_end]} UTC")
			if @residence.update_attributes(params[:residence])
				flash.now[:success] = "Successfully updated residence"
				redirect_to edit_doctor_residence_path(@doctor, @residence)
			else
				redirect_to edit_doctor_residence_path(@doctor, @residence)
			end
		elsif current_user.admin?	# approve residence
			@residence.update_attributes(params[:residence])
		 	flash[:success] = "Successfully apporved residence"
			redirect_to pending_residences_path
		else
			flash[:warning] = "Wrong user!"
			redirect_to root_path
		end
	end

end
