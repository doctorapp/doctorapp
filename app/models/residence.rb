class Residence < ActiveRecord::Base

	attr_accessible :doctor_id, :office_id, :approved, :slot_minutes, :office_hour_start, :office_hour_end, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday

	belongs_to :doctor
	belongs_to :office
	
	has_many :appointments, dependent: :destroy

	validates :doctor_id, presence: true
	validates :office_id, presence: true

	before_create :default_values

	before_save :office_hour_validation
	
	private 

	# Time.parse("16:00").to_s(:time)

		# set the approved tag to false; admin approval needed
		def default_values
			self.approved 			= false
			self.slot_minutes 	= 30
			self.office_hour_start = Time.parse('08:00 UTC')
			self.office_hour_end   = Time.parse('16:00 UTC')
			self.monday 				= false
			self.tuesday				= false
			self.wednesday  		= false
			self.thursday 			= false
			self.friday					= false
			self.saturday				= false
			self.sunday					= false
			nil
		end

		def office_hour_validation
			unless self[:office_hour_end] == nil # when approving residence, office_hour_start/end will be nil
				if self[:office_hour_end] <= self[:office_hour_start] 
					errors[:office_hour_start] << "Office hour start time can't be later than end time!"
					return false
				else
					return true
				end
			end
		end

	# work_days
	#	calendar_settings

end
