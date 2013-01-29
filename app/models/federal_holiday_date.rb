class FederalHolidayDate < ActiveRecord::Base

	attr_accessible :date
	belongs_to :federal_holiday

	validates :date, presence: true

end
