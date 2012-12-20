class AddDomainsDoctorsAssociation < ActiveRecord::Migration
  def change
		
		create_table :doctors_domains, id: false do |t|
			t.integer :doctor_id, null: false
			t.integer :domain_id, null: false
  	end
	end
end
