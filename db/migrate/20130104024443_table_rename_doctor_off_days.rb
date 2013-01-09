class TableRenameDoctorOffDays < ActiveRecord::Migration
  def change
		rename_table :doctor_weekly_off_days, :doctor_work_days
  end
end
