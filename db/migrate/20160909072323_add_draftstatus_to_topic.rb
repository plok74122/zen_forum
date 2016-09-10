class AddDraftstatusToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics, :status_published, :boolean, :default=>:true
  end
end
