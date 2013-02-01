class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.datetime :start
      t.datetime :end
      t.integer :post_code
      t.integer :domain_id
      t.integer :language_id

      t.timestamps
    end
  end
end
