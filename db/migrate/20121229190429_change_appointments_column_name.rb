class ChangeAppointmentsColumnName < ActiveRecord::Migration
  def change
		rename_column :appointments, :allDay, :allday
  end

end
