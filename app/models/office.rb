class Office < User

	has_many :residences, dependent: :destroy
	has_many :doctors, through: :residences, source: :doctor

	def manage!(doctor)
		residences.create!(doctor_id: doctor.id)
	end

	def manage?(doctor)
		residences.find_by_doctor_id(doctor.id)
	end

	def unmanage!(doctor)
		# should have extra approval
		residences.find_by_doctor_id(doctor.id).destroy
	end

end
