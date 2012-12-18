class User < ActiveRecord::Base
 
	attr_accessible :name, :email, :password, :password_confirmation, :user_type, :active

  has_secure_password

  before_save do |user| 
		user.email = email.downcase   #save in lower case
		user.user_type = user_type.downcase   #save in lower case
	end

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
	validates_inclusion_of :user_type, in: ['d', 'o', 'p', 'a']
  validates_inclusion_of :active, in: [true, false]

	def active?
		active
	end

	def doctor?
		user_type == 'd'
	end
		
	def office?
		user_type == 'o'
	end

	def patient?
		user_type == 'p'
	end

	def admin?
		user_type == 'a'
	end

end
