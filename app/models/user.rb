class User < ActiveRecord::Base
 
	attr_accessible :name, :email, :password, :password_confirmation, :active

  has_secure_password

	before_create { generate_token(:remember_token) }
  before_save { |user| user.email = email.downcase }
	before_save :default_values

  validates :name, presence: true, length: { maximum: 50 }
  
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
	validates :password,
		presence: true,
		confirmation: true,
		length: { minimum: 6 }, 
    if: lambda{ new_record? || !password.blank? }  
	# validates only when creating a new record or changed password

	# validates :password_confirmation, presence: true


	# validates_inclusion_of :active, in: [true, false]

	def send_password_reset
 		generate_token(:password_reset_token)
 		self.password_reset_sent_at = Time.zone.now
 		save!
 		UserMailer.password_reset(self).deliver
	end

	private
	
		# create a randomized remember_token for user, for session retrieval
	  def generate_token(column)
		 	begin
	 	  	self[column] = SecureRandom.urlsafe_base64
		 	end	while User.exists?(column => self[column])
	  end

		def default_values
			self.active ||= true
		end

end
