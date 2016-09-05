class AddCommentscountToTopics < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics,:comments_number,:integer
  	add_column :topics,:comments_lastest_time, :datetime
  end
end
