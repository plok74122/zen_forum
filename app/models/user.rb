class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :topics,:dependent=>:destroy
  has_many :comments,:dependent=>:destroy
  has_many :keepships, :dependent=>:destroy
  has_many :keeptopics, :through=>:keepships, :source => :topic

  include Gravtastic
  gravtastic
  
  def keepedTopic?(topic)
  	self.keeptopics.include?(topic)
  end

  def admin?
    self.role == "admin"
  end
end
