class Domain < ActiveRecord::Base
	has_and_belongs_to_many :doctors
  attr_accessible :name
end
