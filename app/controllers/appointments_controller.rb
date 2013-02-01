class AppointmentsController < ApplicationController
  # GET /appointments
  # GET /appointments.json

  before_filter :signed_in_user
  #before_filter :correct_user


  def index

    if ( current_user.type == 'Doctor')
      doctor_id= current_user.id
      #@appointment.patient_id = users.find_by_email(@appointment.)
    elsif ( current_user.type == 'Patient')
      doctor_id = params[:doctor_id]
    end

    @doctor = Doctor.find(doctor_id)

    @appointments = @doctor.appointments.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments }
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    if( @appointment = current_user.appointments.find(params[:id]) )
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/new
  def new
    @appointment = current_user.appointments.new
		@timeslot ||= 30	# should be populated by docotr settings
    @appointment.allDay ||= false

    if(params[:startdate])
      @startdate = DateTime.parse(params[:startdate])
    end
    if(params[:enddate])
      @enddate = DateTime.parse(params[:enddate])
    end


    if ( current_user.type == 'Doctor')
      @appointment.doctor_id= current_user.id
      #@appointment.patient_id = users.find_by_email(@appointment.)
    elsif ( current_user.type == 'Patient')
      @appointment.patient_id = current_user.id
      @appointment.doctor_id = params[:doctor_id]
    end
  
    @doctor = Doctor.find(@appointment.doctor_id)
    

    respond_to do |format|
      format.html #{render :locals => {:slotMinutes =>@slotMinutes} }# new.html.erb
      format.json { render json: @appointment }
      format.js 
    end
  end

  # GET /appointments/1/edit
  def edit
    @appointment = current_user.appointments.find(params[:id])
    @doctor = Doctor.find(@appointment.doctor_id)
    @patient = Patient.find(@appointment.patient_id)
    @timeslot = params[:slotminutes].to_f

    respond_to do |format|
      format.html
      format.json { render json: @appointment, status: :edited, location: @appointment }
      format.js 
    end
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = current_user.appointments.build(params[:appointment])
		#@appointment.start = DateTime.strptime(params[:appointment][:start], '%m/%d/%Y %H:%M')
		#@appointment.end = DateTime.strptime(params[:appointment][:end],'%m/%d/%Y %H:%M')
    if ( current_user.type == 'Doctor')
      @appointment.doctor_id= current_user.id
      #@appointment.patient_id = users.find_by_email(@appointment.)
    elsif ( current_user.type == 'Patient')
      @appointment.patient_id = current_user.id
      @appointment.doctor_id = params[:doctor_id]
    end

    @doctor = Doctor.find(@appointment.doctor_id)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @doctor, notice: 'Appointment was successfully created.' }
        format.json { render json: @appointment, status: :created, location: @appointment }
        format.js { render :layout => false }
      else
				flash.now[:error] =  "Cannot create appointment. pid: #{@appointment.patient_id}. did: #{@appointment.doctor_id}. start: #{@appointment.start}. end: #{@appointment.end}. error: #{@appointment.errors.first}" 
      	format.html { render action: "new" }
				format.json { render json: @appointment.errors, status: :unpcoressable_entity }
				format.js { render :layout => false }
			end
    end
  end

  # PUT /appointments/1
  # PUT /appointments/1.json
  def update
    @appointment = current_user.appointments.find(params[:id])
    @doctor = Doctor.find(@appointment.doctor_id)

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])
        format.html { redirect_to @doctor, notice: 'Appointment was successfully updated.' }
        format.json { head :no_content }
      else
        flash.now[:error] = "Could not edit appointment"
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    # @appointment.destroy
    @appointment = current_user.appointments.find(params[:id])
    @doctor = Doctor.find(@appointment.doctor_id)
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to @doctor,    notice:  " Appointment was successfully canceled."}
      format.js
    end
  end

  private

    def correct_user
      @appointment = current_user.appointments.find_by_id(params[:id])
      redirect_to root_url if @appointment.nil?
    end

end
