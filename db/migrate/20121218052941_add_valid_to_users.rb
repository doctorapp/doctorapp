class AddValidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :valid, :boolean
  end
end
