class Topic < ApplicationRecord
  validates_presence_of :title
	belongs_to :user
	has_many :comments, :dependent=>:destroy
	has_many :topic_categoryships,:dependent=>:destroy
	has_many :categorys, :through=>:topic_categoryships
	has_many :keepships, :dependent=>:destroy
	has_many :keepusers, :through=>:keepships, :source => :user
  has_many :likeships, :dependent=>:destroy
	has_many :like_users, :through=>:likeships, :source => :user
	has_many :subscribeships, :dependent=>:destroy
	has_many :subscirbe_users, :through=>:subscribeships, :source => :user

	# @topic.comments_with_paginate
	def comments_with_paginate(page)
		comments.page(page).per(5)
	end

	has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
