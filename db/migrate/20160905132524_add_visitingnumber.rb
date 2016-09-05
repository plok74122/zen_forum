class AddVisitingnumber < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics, :visitingnumber, :integer
  end
end
