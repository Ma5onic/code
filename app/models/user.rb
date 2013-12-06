class User < ActiveRecord::Base
	has_many :lessons
	
	before_save { email.downcase! }
	before_save { username.downcase! }
	before_create :create_remember_token
	before_create :create_permalink

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

	def complete!(lesson)
    progresses.create!(lesson_id: lesson.id)
  end

  def completed?(lesson)
    progresses.find_by(lesson_id: lesson.id)
  end

  def uncomplete!(lesson)
    progresses.find_by(lesson_id: lesson.id).destroy!
  end

	def to_param
		permalink
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end

		def create_permalink
			self.permalink = username.downcase
		end
end
