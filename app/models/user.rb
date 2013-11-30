class User < ActiveRecord::Base
	before_save { email.downcase! }
	before_save { username.downcase! }

	VALID_USERNAME_REGEXP = /\A^[-a-zA-Z0-9_]*$\z/i
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	validates :username, presence: true, length: { maximum: 50 }, 
											 uniqueness: { case_sensitive: false },
											 format: { with: VALID_USERNAME_REGEXP }
	validates :email, 	 presence: true, format: { with: VALID_EMAIL_REGEX }, 
											 uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

	has_secure_password	
end
