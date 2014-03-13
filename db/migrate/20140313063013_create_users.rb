class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string		:openid
    	t.string		:nickname
    	t.string		:area
      t.timestamps
    end
  end
end
