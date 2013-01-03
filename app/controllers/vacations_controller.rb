class VacationsController < ApplicationController

	before_filter :signed_in_user
	before_filter :doctor_user, only: [:new, :create, :edit, :destory]

	def index
		@vacations = current_user.vacations.all
	end

	def show
		@vacation = current_user.vacations.find(params[:id])
	end

	def new
		@vacation = current_user.vacations.new
	end

	def create
		@vacation = current_user.vacations.build(params[:vacation])
		@vacation.start = DateTime.strptime(params[:vacation][:start], '%m/%d/%Y')
		@vacation.end = DateTime.strptime(params[:vacation][:end], '%m/%d/%Y')
		@vacation.doctor_id = current_user.id
		if @vacation.save
			flash[:success] = "Successfully added vacation"
			redirect_to root_url
		else
			flash.now[:error] = "Cannot create vacation!"
			render :new
		end
	end

	def destroy
		@vacation = current_user.vacations.find(params[:id])
		@vacation.destroy
		flash[:success] = "Successfully deleted vacation"
	end

end
