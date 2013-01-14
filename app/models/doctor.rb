class Doctor < User
	attr_accessible :language_ids
	attr_accessible :domain_ids
	attr_accessible :work_days
	
	has_and_belongs_to_many :languages
	has_and_belongs_to_many :domains

	has_many :appointments, dependent: :destroy

	has_many :vacations, dependent: :destroy
	has_one :work_days, dependent: :destroy, class_name: "DoctorWorkDay"
	has_one :calendar_setting, dependent: :destroy

	after_create :create_calendar_setting
  after_initialize :create_work_days


	def create_calendar_setting
		self.calendar_setting = CalendarSetting.create(:slotMinutes => 30, :firstHour => 8, :minTime => 8, :maxTime => 18, :defaultEventMinutes => 30, :doctor_id => self.id )
	end

	def create_work_days
		self.work_days = DoctorWorkDay.create(monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: false, sunday: false)	unless self.work_days != nil
	end

	def self.search_by_name(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			scoped
		end
	end

	def self.paginated_search_by_name(search, page)
		if search
			where('name LIKE ?', "%#{search}%").paginate(page: page)
		else
			paginate(page: page)
		end
	end

# has_many :residence
#	has_many :office through :residence
# has_one :doctor_info

end
