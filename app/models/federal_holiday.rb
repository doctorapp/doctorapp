class FederalHoliday < ActiveRecord::Base

	attr_accessible :name
	has_many :dates, class_name: "FederalHolidayDate"

	has_and_belongs_to_many :doctors

	validates :name, presence: true

end
