class ChangeDatetimeInInformation < ActiveRecord::Migration
  def change
  	change_column :information, :release_time, :date
  end
end
