class Patient < User
	has_many :favorite_doctors, dependent: :destroy
	has_many :doctors, through: :favorite_doctors, source: :doctor

	has_many :appointments, dependent: :destroy

	def favorite!(doctor)
		favorite_doctors.create!(doctor_id: doctor.id)
	end

	def favorite?(doctor)
		favorite_doctors.find_by_doctor_id(doctor.id)
	end

	def unfavorite!(doctor)
		favorite_doctors.find_by_doctor_id(doctor.id).destroy
	end

end
