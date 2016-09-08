class Comment < ApplicationRecord
	validates_presence_of :content
	belongs_to :topic
	belongs_to :user

	def is_author?(u)
		self.user == u
	end
end