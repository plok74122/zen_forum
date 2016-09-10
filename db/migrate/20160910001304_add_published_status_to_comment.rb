class AddPublishedStatusToComment < ActiveRecord::Migration[5.0]
  def change
  	add_column :comments, :status_published, :boolean, :default => :true
  end
end
