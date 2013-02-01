class Doctor < User
	attr_accessible :language_ids
	attr_accessible :domain_ids
	attr_accessible :federal_holiday_ids
	
	has_and_belongs_to_many :languages
	has_and_belongs_to_many :domains
	has_and_belongs_to_many :federal_holidays

	has_many :residences, dependent: :destroy
	has_many :offices, through: :residences, dependent: :destroy

	has_many :vacations, dependent: :destroy
	has_many :federals, dependent: :destroy	
	has_many :doctor_off_days, dependent: :destroy

	def self.search_by_name(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			scoped
		end
	end

# has_many :residence
#	has_many :office through :residence
# has_one :doctor_info

end
