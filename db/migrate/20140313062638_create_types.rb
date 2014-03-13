class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
    	t.string		:keyword
    	t.string		:name
    	t.string		:description
      t.timestamps
    end
  end
end
