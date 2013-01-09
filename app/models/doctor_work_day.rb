class DoctorWorkDay < ActiveRecord::Base
	belongs_to :doctor
	attr_accessible :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday
end
