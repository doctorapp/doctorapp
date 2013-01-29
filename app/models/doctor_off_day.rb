class DoctorOffDay < ActiveRecord::Base
  attr_accessible :title, :description, :doctor_id, :end, :start

	belongs_to :doctor

	validates :start, 	presence: true
	validates :end, 		presence: true
	validates :doctor, 	presence: true

	validate :start_date_cannot_after_end_date
	
 	default_scope order: 'doctor_off_days.start ASC'

	private
		def	start_date_cannot_after_end_date
			if self[:end] < self[:start]
				errors[:start] << "Start time can't be later than end time!"
				return false
			else
				return true
			end
		end

end
