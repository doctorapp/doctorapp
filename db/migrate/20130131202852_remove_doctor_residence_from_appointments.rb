class RemoveDoctorResidenceFromAppointments < ActiveRecord::Migration
  def change
		remove_column :appointments, :docotr_id
		remove_column :appointments, :office_id
		add_column :appointments, :residence_id, :integer
		
		remove_index :appointments, :doctor_id
		add_index :appointments, :residence_id
  end
end
