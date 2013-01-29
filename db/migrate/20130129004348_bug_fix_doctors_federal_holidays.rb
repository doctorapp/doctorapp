class BugFixDoctorsFederalHolidays < ActiveRecord::Migration
  def change
		rename_column :doctors_federal_holidays, :dcotor_id, :doctor_id
  end
end
