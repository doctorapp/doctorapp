class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
		remove_column :users, :user_type
 		add_index :users, :type
	end

end
