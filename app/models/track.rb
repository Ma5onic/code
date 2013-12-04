class Track < ActiveRecord::Base
	belongs_to :course
	has_many :lessons
	before_create :create_permalink

	validates :name,        presence: true, length: { maximum: 50 }
	validates :description, presence: true, length: { maximum: 250 },
													uniqueness: { case_sensitive: false }
	validates :permalink,   length: { maximum: 50 },
													uniqueness: { case_sensitive: false }

	def to_param
		permalink
	end

	private

		def create_permalink
			link = self.name.dup
			replacements = [ ["\'", ""], [" ", "-"], ["!", ""] ]
			replacements.each {|replacement| link.gsub!(replacement[0], replacement[1])}
			self.permalink = link.downcase
		end
end
