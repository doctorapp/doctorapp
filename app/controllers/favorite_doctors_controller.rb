class FavoriteDoctorsController < ApplicationController
	before_filter :signed_in_user
	before_filter :signed_in_user, only: [:edit, :upadte, :show, :index] 
	before_filter :correct_user, only: [:edit, :update]


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
