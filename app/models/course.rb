class Course < ActiveRecord::Base
	before_create :create_permalink

	validates :description, presence: true, length: { maximum: 140 }
	validates :name,        presence: true, length: { maximum: 50 },
													uniqueness: { case_sensitive: false }

	private

		def create_permalink
   		link = User.name.sub!(' ', '-').downcase
   		self.permalink = link
		end
end
