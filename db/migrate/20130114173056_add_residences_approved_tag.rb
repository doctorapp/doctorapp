class AddResidencesApprovedTag < ActiveRecord::Migration
  def change
		add_column :residences, :approved, :boolean
		add_index :residences, :approved
  end
end
