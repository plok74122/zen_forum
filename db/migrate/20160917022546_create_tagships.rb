class CreateTagships < ActiveRecord::Migration[5.0]
  def change
    create_table :tagships do |t|
    	t.integer :tag_id
    	t.integer :topic_id
      t.timestamps
    end

    add_index :Tagships, :tag_id
    add_index :Tagships, :topic_id
  end
end
