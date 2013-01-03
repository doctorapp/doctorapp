class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.integer :doctor_id
      t.date :start
      t.date :end
      t.string :description

      t.timestamps
    end

		add_index :vacations, :doctor_id
  end
end
