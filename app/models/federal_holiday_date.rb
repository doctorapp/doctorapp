class FederalHolidayDate < ActiveRecord::Base

	attr_accessible :date, :federal_holiday_id
	belongs_to :federal_holiday

	validates :date, presence: true

end
