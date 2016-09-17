class Tag < ApplicationRecord
	has_many :topics, :through => :tagships
	has_many :tagships, :dependent => :destroy
	validates_presence_of :name
end
