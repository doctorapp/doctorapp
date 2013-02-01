class AddColumnsToFederalHolidays < ActiveRecord::Migration
  def change
		add_column :federal_holidays, :chronic_pattern, :string
		add_column :federal_holidays, :base_date, :string
  end
end
