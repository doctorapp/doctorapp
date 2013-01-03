class Doctor < User
	
	has_and_belongs_to_many :languages
	has_and_belongs_to_many :domains

	has_many :appointments, dependent: :destroy
	has_many :vacations, dependent: :destroy

	attr_accessible :language_ids
	attr_accessible :domain_ids

	has_one :calendar_setting, dependent: :destroy

	after_create :create_calendar_setting

	def create_calendar_setting
		self.calendar_setting = CalendarSetting.create(:slotMinutes => 30, :firstHour => 8, :minTime => 8, :maxTime => 18, :defaultEventMinutes => 30, :doctor_id => self.id )
	end
# has_many :residence
#	has_many :office through :residence

# has_one :doctor_info

end
