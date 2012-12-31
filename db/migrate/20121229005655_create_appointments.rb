class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer 	:doctor_id
      t.integer 	:patient_id
			t.string  	:title
			t.boolean 	:allDay
			t.datetime 	:start
			t.datetime	:end
			t.string		:url
			t.boolean 	:editable
			t.string		:source

      t.timestamps
    end

		add_index :appointments, :patient_id
		add_index :appointments, :doctor_id
  end
end
