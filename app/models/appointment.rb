class Appointment < ActiveRecord::Base
  attr_accessible :doctor_id, :patient_id, :title, :start, :end, :allday

	belongs_to :patient
	belongs_to :doctor


	validates :title, presence: true
	validates :start, presence: true
	validates :end, presence: true
	validates :doctor_id, presence: true
	
	validate :start_datetime_cannot_after_end_datetime

	default_scope order: 'appointments.start DESC'

	private

		def start_datetime_cannot_after_end_datetime
			if self[:end] < self[:start] # why self[:end] not :end ? of course...
				errors[:start] << "Start time can't be later than end time!"
				return false
			else
				return true
			end
		end
	
end
