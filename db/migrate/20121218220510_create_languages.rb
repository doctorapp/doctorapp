class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name

      t.timestamps
    end

		create_table :doctors_languages, id: false do |t|
			t.integer :doctor_id, null: false
			t.integer :language_id, null: false
		end

  end
end
