class VacationsController < ApplicationController

	before_filter :signed_in_user
	#before_filter :doctor_user, only: [:new, :create, :edit, :destory, :index]

	def index
		
		if ( current_user.type == 'Doctor')
      		doctor_id= current_user.id
      		#@appointment.patient_id = users.find_by_email(@appointment.)
    	elsif ( current_user.type == 'Patient')
      		doctor_id = params[:doctor_id]
    	end

    	@doctor = Doctor.find(doctor_id)
		@vacations = @doctor.vacations.where('end >= ?', Time.now).paginate(page: params[:page])
		respond_to do |format|
      		format.html # index.html.erb
      		format.json { render json: @vacations }
    	end
    	
	end

	def show
		@vacation = current_user.vacations.find(params[:id])
	end

	def new
		@vacation = current_user.vacations.new
		@doctor = Doctor.find(current_user.id)
	end

	def create
		@vacation = current_user.vacations.build(params[:vacation])
		@vacation.start = DateTime.strptime(params[:vacation][:start], '%m/%d/%Y')
		@vacation.end = DateTime.strptime(params[:vacation][:end], '%m/%d/%Y')+1.day
		@vacation.doctor_id = current_user.id
		@vacation.allDay ||= false
		@vacation.title ||= 'Vacation'

		@doctor= Doctor.find(current_user.id)

		if @vacation.save
			flash[:success] = "Successfully added vacation"
			redirect_to @doctor
		else
			flash.now[:error] = "Cannot create vacation!"
			render :new
		end
	end

	def destroy
		@vacation = current_user.vacations.find(params[:id])
		@doctor= Doctor.find(@vacation.doctor_id)
		@vacation.destroy
		flash[:success] = "Successfully deleted vacation"
		redirect_to @doctor
	end

end
