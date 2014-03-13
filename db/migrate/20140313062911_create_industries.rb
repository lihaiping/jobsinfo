class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
    	t.string		:name
    	t.string		:description
      t.timestamps
    end
  end
end
