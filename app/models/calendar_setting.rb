class CalendarSetting < ActiveRecord::Base
  attr_accessible :defaultEventMinutes, :doctor_id, :firstHour, :maxTime, :minTime, :slotMinutes

  validates :doctor_id, presence: true, :uniqueness => true
  validates :defaultEventMinutes, presence: true
  validates :firstHour, presence: true
  validates :minTime, presence: true
  validates :maxTime, presence: true
  validates :slotMinutes, presence: true

  belongs_to :doctors
end
