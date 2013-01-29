class AddDoctorsFederalHolidays < ActiveRecord::Migration
  def change
		create_table :doctors_federal_holidays, id: false do |t|
			t.integer :dcotor_id, null: false
			t.integer :federal_holiday_id, null: false
		end
  end
end
