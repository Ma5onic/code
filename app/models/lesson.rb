class Lesson < ActiveRecord::Base
	belongs_to :track
	before_create :create_permalink

	validates :content,     presence: true
	validates :task,        presence: true
	validates :name,        presence: true, length: { maximum: 50 },
													uniqueness: { case_sensitive: false }
	validates :permalink,   length: { maximum: 50 },
													uniqueness: { case_sensitive: false }

	def to_param
		permalink
	end
	
	private

		def create_permalink
   		link = self.name.dup
   		self.permalink = link.gsub(' ', '-').downcase
		end
end
