class LimitUserTypeLength < ActiveRecord::Migration
  def change
		change_column :users, :user_type, :string, :limit => 1
  end
end
