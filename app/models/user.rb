class User < ActiveRecord::Base
	before_save { email.downcase! }
	before_save { username.downcase! }
	before_create :create_remember_token

	VALID_USERNAME_REGEXP = /\A^[-a-zA-Z0-9_]*$\z/i
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	validates :username, presence: true, length: { maximum: 50 }, 
											 uniqueness: { case_sensitive: false },
											 format: { with: VALID_USERNAME_REGEXP }
	validates :email, 	 presence: true, format: { with: VALID_EMAIL_REGEX }, 
											 uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

	has_secure_password

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
