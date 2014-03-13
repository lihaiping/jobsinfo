class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
    	t.integer	:type_id
    	t.integer	:industry_id
    	t.string		:title
    	t.string		:abstract
    	t.text		:content
    	t.string		:image
    	t.string		:link
      t.timestamps
    end
  end
end
