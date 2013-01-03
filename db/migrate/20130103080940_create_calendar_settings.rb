class CreateCalendarSettings < ActiveRecord::Migration
  def change
    create_table :calendar_settings do |t|
      t.integer :doctor_id
      t.integer :slotMinutes
      t.integer :minTime
      t.integer :maxTime
      t.integer :firstHour
      t.integer :defaultEventMinutes

      t.timestamps
    end
  end
end
