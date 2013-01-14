class AddResidences < ActiveRecord::Migration
  def change
		create_table :residences do |t|
			t.integer :doctor_id
			t.integer :office_id
			# other residences attributes that should have been refactored in:
			# 	calendar_setting time_slot
			# 	calendar_setting office_hour
			#		work_days
			
			t.timestamps
		end

		add_index :residences, :doctor_id
		add_index :residences, :office_id
  end

end
