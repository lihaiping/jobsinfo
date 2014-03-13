class ChangeTimeInInformation < ActiveRecord::Migration
  def change
  	remove_column :information, :release_time
  	add_column :information, :release_time, :datetime
	change_column_null :information, :release_time, false
  end
end
