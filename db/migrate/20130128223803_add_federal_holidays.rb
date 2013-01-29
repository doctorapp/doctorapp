class AddFederalHolidays < ActiveRecord::Migration
  def change
		create_table :federal_holiday_dates do |t|
			t.integer :federal_holiday_id
			t.datetime :date

			t.timestamps
		end

		create_table :federal_holidays do |t|
			t.string :name
			
			t.timestamps
		end

  end
end
