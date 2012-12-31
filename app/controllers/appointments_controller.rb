class AppointmentsController < ApplicationController
  # GET /appointments
  # GET /appointments.json

  before_filter :signed_in_user
  #before_filter :correct_user

  def upcoming
    @appointments = current_user.appointments.find(:all, :order => 'start DESC', :conditions => ['start >= ?',Time.now] ) 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments }
    end
  end

  def index
    @appointments = current_user.appointments.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments }
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @appointment = current_user.appointments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/new
  def new
    @appointment = current_user.appointments.new
		@timeslot ||= 30	# should be populated by docotr settings

    respond_to do |format|
      format.html #{render :locals => {:slotMinutes =>@slotMinutes} }# new.html.erb
      format.json { render json: @appointment }
      format.js 
    end
  end

  # GET /appointments/1/edit
  def edit
    @appointment = current_user.appointments.find(params[:id])
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
    @appointment.patient_id= current_user.id
		@appointment.start = DateTime.strptime(params[:appointment][:start], '%m/%d/%Y %H:%M')
		@appointment.end = DateTime.strptime(params[:appointment][:end],'%m/%d/%Y %H:%M')
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to root_url, notice: 'Appointment was successfully created.' }
        format.json { render json: @appointment, status: :created, location: @appointment }
        format.js { render :layout => false }
      else
				flash.now[:error] =  "Cannot create appointment. pid: #{@appointment.patient_id}. did: #{@appointment.doctor_id}. start: #{@appointment.start}. end: #{@appointment.end}. error: #{@appointment.errors.first}" 
      	format.html { render 'static_pages/home' }
				format.json { render json: @appointment.errors, status: :unpcoressable_entity }
				format.js { render :layout => false }
			end
    end
  end

  # PUT /appointments/1
  # PUT /appointments/1.json
  def update
    @appointment = current_user.appointments.find(params[:id])

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])
        format.html { redirect_to root_url, notice: 'Appointment was successfully updated.' }
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
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private

    def correct_user
      @appointment = current_user.appointments.find_by_id(params[:id])
      redirect_to root_url if @appointment.nil?
    end

end
