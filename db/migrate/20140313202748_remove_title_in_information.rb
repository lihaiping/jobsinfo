class RemoveTitleInInformation < ActiveRecord::Migration
  def change
  	remove_column :information, :title, :string
  	remove_column :information, :abstract, :string
  end
end
