class DocotrOffDaysAsSti < ActiveRecord::Migration
  def change
		rename_table :vacations, :doctor_off_days
		add_column :doctor_off_days, :type, :string
		remove_column :doctor_off_days, :allDay
  end
end
