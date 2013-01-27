class AddWorkDaysIntoResidences < ActiveRecord::Migration
  def change
		add_column :residences, :monday, :boolean
		add_column :residences, :tuesday, :boolean
		add_column :residences, :wednesday, :boolean
		add_column :residences, :thursday, :boolean
		add_column :residences, :friday, :boolean
		add_column :residences, :saturday, :boolean
		add_column :residences, :sunday, :boolean
  end
end
