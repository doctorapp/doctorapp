class ResidencesController < ApplicationController

	before_filter :signed_in_user
	before_filter :admin_user, only: [:pending]
	before_filter :office_user, only: [:create, :destroy, :edit]

	respond_to :html, :js

	def index
		if current_user.admin? 
			@residences = Residence.all
		elsif current_user.office?
			@residences = current_user.residences
		elsif current_user.doctor?
			@residences = current_user.residences
		else
			flash[:warning] = "Action not allowed!"
			redirect_to root_path
		end
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

	def edit
		@residence = Residence.find(params[:id])
		@doctor = @residence.doctor
	end
	
	def update
		if current_user.office? || current_user.admin?
			@residence = Residence.find(params[:id])
		 	@doctor = @residence.doctor
		 	params[:residence][:office_hour_start] = Time.parse("#{params[:office_hour_start]} UTC")
			params[:residence][:office_hour_end] = Time.parse("#{params[:office_hour_end]} UTC")
			if @residence.update_attributes(params[:residence])
				flash.now[:success] = "Successfully updated residence"
				if current_user.admin?
					redirect_to pending_residences_path
				else current_user.office?
					render 'edit'
				end
			else
				render 'edit'
			end
		else
			flash[:warning] = "Wrong user!"
			redirect_to root_path
		end
	end

end
