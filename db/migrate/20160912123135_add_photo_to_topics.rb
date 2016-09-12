class AddPhotoToTopics < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :topics, :photo
  end
end	
