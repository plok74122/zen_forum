class Topic < ApplicationRecord
  validates_presence_of :title
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :topic_categoryships, :dependent => :destroy
  has_many :categorys, :through => :topic_categoryships
  has_many :keepships, :dependent => :destroy
  has_many :keepusers, :through => :keepships, :source => :user
  has_many :likeships, :dependent => :destroy
  has_many :like_users, :through => :likeships, :source => :user
  has_many :subscribeships, :dependent => :destroy
  has_many :subscirbe_users, :through => :subscribeships, :source => :user
  has_many :tagships, :dependent => :destroy
  has_many :tags, :through => :tagships

  # @topic.comments_with_paginate
  def comments_with_paginate(page)
    comments.page(page).per(5)
  end

  def tag_list
    self.tags.map { |x| x.name }.join(",")
  end

  def tag_list=(arr)
    self.tag_ids = arr.map do |tag_name|
      tag_name.strip!
      tag = Tag.find_by_name(tag_name) || Tag.create(:name => tag_name)
      tag.id
    end
  end

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
