class Doctor < User
	
	has_and_belongs_to_many :languages
	has_and_belongs_to_many :domains

	has_many :appointments, dependent: :destroy
	has_many :vacations, dependent: :destroy

	attr_accessible :language_ids
	attr_accessible :domain_ids

# has_many :residence
#	has_many :office through :residence

# has_one :doctor_info

end
