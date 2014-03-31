class AddSubscribeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :subscribe, :integer
  	change_column_null :users, :subscribe, false
  end
end
