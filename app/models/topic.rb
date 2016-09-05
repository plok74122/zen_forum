class Topic < ApplicationRecord
    validates_presence_of :title
	belongs_to :user
	has_many :comments
	has_many :topic_categoryships
	has_many :categorys, :through=>:topic_categoryships
end
