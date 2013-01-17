class AddSettingsIntoResidence < ActiveRecord::Migration
  def change
		add_column :residences, :slot_minutes, :integer
		add_column :residences, :office_hour_start, :time
		add_column :residences, :office_hour_end, :time
  end
end
