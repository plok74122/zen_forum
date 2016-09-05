class AddProfileToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users,:profile,:text
  	add_column :users,:name,:string
  end
end
