class VacationsController < ApplicationController

	before_filter :signed_in_user
	#before_filter :doctor_user, only: [:new, :create, :edit, :destory, :index]

	def index	
	  @doctor = current_doctor
		@vacations = @doctor.vacations.where('end > ?', Time.now)
#@vacations = @doctor.vacations.where('end >= ?', Time.now).paginate(page: params[:page])
		respond_to do |format|
      		format.html # index.html.erb
      		format.json { render json: @vacations }
    end
    	
	end

	def show
		@doctor = current_doctor
		@vacation = @doctor.vacations.find(params[:id])
	end

	def new
		@doctor = current_doctor
		@vacation = @doctor.vacations.new
	end

	def create
		@doctor = current_doctor
		@vacation = @doctor.vacations.build(params[:vacation])
		@vacation.start = DateTime.strptime(params[:vacation][:start], '%m/%d/%Y')
		@vacation.end = DateTime.strptime(params[:vacation][:end], '%m/%d/%Y')+1.day
		@vacation.doctor_id = @doctor.id
		@vacation.title ||= 'Vacation'

		if @vacation.save
			flash[:success] = "Successfully added vacation"
			redirect_to doctor_vacations_path(@doctor.id)
		else
			flash.now[:error] = "Cannot create vacation!"
			render :new
		end
	end

	def destroy
		@doctor = current_doctor
		@vacation = @doctor.vacations.find(params[:id])
		@vacation.destroy
		flash[:success] = "Successfully deleted vacation"
		redirect_to @doctor
	end

	private
	
		def current_doctor
			if current_user.doctor?
  	  	doctor_id = current_user.id
   	  	#@appointment.patient_id = users.find_by_email(@appointment.)
  	  elsif params[:doctor_id]
				doctor_id = params[:doctor_id]
			elsif params[:id]
				residence = Residence.find(params[:id])
		 		doctor_id = residence.doctor_id
			end
			Doctor.find(doctor_id)
		end

end
