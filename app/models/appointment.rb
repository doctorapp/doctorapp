class Appointment < ActiveRecord::Base
  attr_accessible :residence_id, :title, :start, :end, :allDay

	belongs_to :patient
	belongs_to :residence

	validates :title, presence: true
	validates :start, presence: true
	validates :end, presence: true
	validates :patient_id, presence: true
	validates :residence_id, presence: true
	validate :start_datetime_cannot_after_end_datetime
	validate :check_conflict

	default_scope order: 'appointments.start DESC'

	private

		def start_datetime_cannot_after_end_datetime
			if self[:end] <= self[:start] # why self[:end] not :end ?   of course...
				errors[:start] << "Start time can't be later than end time!"
				return false
			else
				return true
			end
		end

		def check_conflict
			#@appointments = Appointment.where("doctor_id= ? and ( start between ? AND ? or end between ? and ?) ", self[:doctor_id],self[:start], self[:end], self[:start],self[:end]) 
			@appointments = Appointment.where("doctor_id= ? and ( ( start < ? AND  end > ? ) or ( start < ? and end > ? ) or (start > ? and start < ?))", self[:doctor_id],self[:start], self[:start], self[:end], self[:end], self[:start], self[:end])
			#@appointments = Appointment.where("doctor_id= ?",202)
			
			if @appointments.any?
				errors[:title] << "The appointment being created is conflict with an existing appointment: "+@appointments[0].title
				return false
			else
				return true
			end
			
			
		end
	
end
