class Lesson < ActiveRecord::Base
	belongs_to :track

	before_validation :create_permalink

	validates :name,         presence: true, length: { maximum: 50 },
													 uniqueness: { case_sensitive: false }
	validates :content,      presence: true
	validates :instructions, presence: true
	validates :lesson_order, presence: true, uniqueness: true
	validates :permalink,    length: { maximum: 50 },
													 uniqueness: { case_sensitive: false }

	def to_param
		permalink
	end
	
	private

		def create_permalink
			link = self.name.dup
			replacements = [ ["\'", ""], [" ", "-"], ["!", ""], ["?", ""] ]
			replacements.each { |replacement| link.gsub!(replacement[0], replacement[1]) }
			self.permalink = link.downcase
			self.lesson_order = self.order.to_s + '-' + self.track.permalink
		end
end
