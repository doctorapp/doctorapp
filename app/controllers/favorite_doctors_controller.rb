class FavoriteDoctorsController < ApplicationController
	before_filter :signed_in_user

	respond_to :html, :js
	def create
		@doctor = Doctor.find(params[:favorite_doctor][:doctor_id])
		current_user.favorite!(@doctor)
		respond_with @doctor
	end

	def destroy
		@doctor = FavoriteDoctor.find(params[:id]).doctor
		current_user.unfavorite!(@doctor)
		respond_with @doctor
	end

end
