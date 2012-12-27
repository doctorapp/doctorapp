class FavoriteDoctorsController < ApplicationController
	before_filter :signed_in_user
# before_filter :signed_in_patient

	def create
		@doctor = Doctor.find(params[:favorite_doctor][:doctor_id])
		current_user.favorite!(@doctor)
		redirect_to @doctor
	end

	def destroy
		@doctor = Doctor.find(params[:favorite_doctor][:doctor_id])
		current_user.unfavorite!(@doctor)
		redirect_to @doctor
	end

end
