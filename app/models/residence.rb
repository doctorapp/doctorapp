class Residence < ActiveRecord::Base

	attr_accessible :doctor_id, :office_id, :approved

	belongs_to :doctor
	belongs_to :office
	
	validates :doctor_id, presence: true
	validates :office_id, presence: true

	before_save :default_values

	private 

		# set the approved tag to false; admin approval needed
		def default_values
			self.approved ||= false
			nil
		end

	# work_days
	#	calendar_settings

end
