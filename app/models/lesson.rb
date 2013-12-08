class Lesson < ActiveRecord::Base
	belongs_to :track
	belongs_to :user

	before_validation :create_permalink

	validates :name,         presence: true, length: { maximum: 50 },
													 uniqueness: { case_sensitive: false }
	validates :content,      presence: true
	validates :instructions, presence: true
	validates :order,        presence: true
	validates :permalink,    length: { maximum: 50 },
													 uniqueness: { case_sensitive: false }
	validates :user_id,      presence: true
	validates :track_id,     presence: true

	def to_param
		permalink
	end
	
	private

		def create_permalink
			link = self.name.dup
			replacements = [ ["\'", ""], [" ", "-"], ["!", ""], ["?", ""], [";", ""], [":", ""], [",", ""], [".", ""] ]
			replacements.each { |replacement| link.gsub!(replacement[0], replacement[1]) }
			self.permalink = link.downcase
		end
end
