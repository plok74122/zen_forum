class CreateSubscribeships < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribeships do |t|
    	t.integer :user_id
    	t.integer :topic_id
      t.timestamps
    end

    add_index :subscribeships, :user_id
    add_index :subscribeships, :topic_id
  end
end
