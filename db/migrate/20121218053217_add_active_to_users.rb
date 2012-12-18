class AddActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean
		remove_column :users, :valid
  end
end
