class AddWeeklyOffDays < ActiveRecord::Migration
  def change
		create_table :doctor_weekly_off_days do |t| 
			t.integer :doctor_id
			t.boolean :monday
			t.boolean :tuesday
			t.boolean :wednesday
			t.boolean :thursday
			t.boolean :friday
			t.boolean :saturday
			t.boolean :sunday

			t.timestamps
		end

		add_index :doctor_weekly_off_days, :doctor_id
  end
end
