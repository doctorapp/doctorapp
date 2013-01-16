class ResidencesController < ApplicationController

	before_filter :signed_in_user
	before_filter :admin_user, only: [:index] 

	respond_to :html, :js

	def index
		@residences = Residence.all
	end

	def pending
		@residences = Residence.where(approved: false)
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

	def update
		@residence = Residence.find(params[:id])
		@residence.update_attributes(params[:residence])
		flash[:success] = "Successfully approved office/doctor affiliation"
		redirect_to pending_residences_path
	end

end
