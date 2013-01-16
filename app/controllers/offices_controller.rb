class OfficesController < ApplicationController

	before_filter :admin_user, only: [:destroy]
	before_filter :signed_in_sign_up, only: [:new, :create]
	before_filter :signed_in_user, only: [:edit, :update, :show, :index]
	before_filter :correct_user, only: [:edit, :update]

	def index
		@offices = Office.paginate(page: params[:page])
	end

	def new
		@office = Office.new
	end

	def create
		@office = Office.new(params[:office])
		if @office.save
			UserMailer.welcome_email(@office).deliver
			sign_in @office
			flash[:success] = "Welcome to GSAD!"
			redirect_to @office
		else
			render 'new'
		end
	end

	def edit
		@office = Office.find(params[:id])
	end

	def update
		@office = Office.find(params[:id])
		if @office.update_attributes(params[:office])
			sign_in @office
			flash[:success] = "Successfully updated profile!"
			redirect_to @office
		else
			render 'edit'
		end
	end

	def show
		@office = Office.find(params[:id])
		@doctors = @office.doctors
	end

	def destroy
		Office.find(params[:id]).destroy
		flash[:success] = "Office user deleted!"
		redirect_to offices_path
	end

end
