class ChangeAppointmentsColumnName2 < ActiveRecord::Migration
  def change
		rename_column :appointments, :allday, :allDay
  end

end