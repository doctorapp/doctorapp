class AddUniqueIndexToLanguagesDomains < ActiveRecord::Migration
  def change
		remove_column :doctors_domains, :language_id
		add_column :doctors_domains, :domain_id, :integer
		add_index :doctors_languages, [:doctor_id, :language_id], unique: true
		add_index :doctors_domains, [:doctor_id, :domain_id], unique: true
  end
end
