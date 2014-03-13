class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
    	t.integer	:type_id
    	t.integer	:job_id
    	t.string		:title
    	t.string		:abstract
    	t.time		:release_time
    	t.string		:company
    	t.string		:position
    	t.string		:experience
    	t.string		:salary
    	t.text		:requirement
    	t.string		:contact
    	t.string		:image
    	t.string		:link
      t.timestamps
    end
  end
end
