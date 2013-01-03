class CalendarSettingsController < ApplicationController
  # GET /calendar_settings
  # GET /calendar_settings.json

  before_filter :signed_in_user 
  before_filter :doctor?

  def index
    @calendar_settings = CalendarSetting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendar_settings }
    end
  end

  # GET /calendar_settings/1
  # GET /calendar_settings/1.json
  def show
    @calendar_setting = CalendarSetting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calendar_setting }
    end
  end

  # GET /calendar_settings/new
  # GET /calendar_settings/new.json
  def new
    @calendar_setting = CalendarSetting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calendar_setting }
    end
  end

  # GET /calendar_settings/1/edit
  def edit
    @calendar_setting = CalendarSetting.find(params[:id])
  end

  # POST /calendar_settings
  # POST /calendar_settings.json
  def create
    @calendar_setting = CalendarSetting.new(params[:calendar_setting])
    @calendar_setting.doctor_id = current_user.id
    respond_to do |format|
      if @calendar_setting.save
        format.html { redirect_to @calendar_setting, notice: 'Calendar setting was successfully created.' }
        format.json { render json: @calendar_setting, status: :created, location: @calendar_setting }
      else
        format.html { render action: "new" }
        format.json { render json: @calendar_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calendar_settings/1
  # PUT /calendar_settings/1.json
  def update
    @calendar_setting = CalendarSetting.find(params[:id])

    respond_to do |format|
      if @calendar_setting.update_attributes(params[:calendar_setting])
        format.html { redirect_to @calendar_setting, notice: 'Calendar setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calendar_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_settings/1
  # DELETE /calendar_settings/1.json
  def destroy
    @calendar_setting = CalendarSetting.find(params[:id])
    @calendar_setting.destroy

    respond_to do |format|
      format.html { redirect_to calendar_settings_url }
      format.json { head :no_content }
    end
  end
end
