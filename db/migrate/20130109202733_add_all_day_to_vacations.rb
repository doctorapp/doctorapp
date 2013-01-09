class AddAllDayToVacations < ActiveRecord::Migration
  def change
  	add_column :vacations, :allDay, :boolean
  	remove_column :vacations, :start
  	remove_column :vacations, :end
  	add_column :vacations, :start, :datetime
  	add_column :vacations, :end, :datetime

  end
end
