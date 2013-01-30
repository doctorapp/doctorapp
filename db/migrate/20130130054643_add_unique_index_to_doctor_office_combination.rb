class AddUniqueIndexToDoctorOfficeCombination < ActiveRecord::Migration
  def change
		add_index :residences, [:doctor_id, :office_id], unique: true
  end
end
