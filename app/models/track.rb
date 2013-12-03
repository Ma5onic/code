class Track < ActiveRecord::Base
	belongs_to :course
	before_create :create_permalink

	validates :name,        presence: true, length: { maximum: 50 }
	validates :description, presence: true, length: { maximum: 250 },
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
