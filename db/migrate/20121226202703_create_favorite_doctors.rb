class CreateFavoriteDoctors < ActiveRecord::Migration
  def change
    create_table :favorite_doctors do |t|
      t.integer :doctor_id
      t.integer :patient_id

      t.timestamps
    end

		add_index :favorite_doctors, :doctor_id
		add_index :favorite_doctors, :patient_id
		add_index :favorite_doctors, [:doctor_id, :patient_id], unique: true
  end
end
