class FederalHoliday < ActiveRecord::Base

	attr_accessible :name, :chronic_pattern, :base_date

	has_many :dates, class_name: "FederalHolidayDate"

	has_and_belongs_to_many :doctors

	validates :name, presence: true
	validates :chronic_pattern, presence: true

end
