class FavoriteDoctor < ActiveRecord::Base
  attr_accessible :doctor_id

	belongs_to :doctor # this is crucial for successful has_many through

	validates :doctor_id, presence: true
	validates :patient_id, presence: true

#	belongs_to :patients
end
