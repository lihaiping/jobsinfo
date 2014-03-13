class ChangeConstraintsOfTables < ActiveRecord::Migration
  def change
  	add_index :types, :keyword, :unique => true
  	change_column_null :types, :keyword, false, :default => ""
  	change_column_null :types, :name, false, :default => ""

  	change_column_null :industries, :name, false, :default => ""

  	change_column_null :jobs, :name, false, :default => ""
  	change_column_null :jobs, :industry_id, false

	change_column_null :information, :type_id, false
	change_column_null :information, :job_id, false
	change_column_null :information, :title, false, :default => ""
	change_column_null :information, :release_time, false
	change_column_null :information, :company, false, :default => ""
	change_column_null :information, :position, false, :default => ""
	change_column_null :information, :experience, false, :default => "不限"
	change_column_null :information, :salary, false, :default => "面议"
	change_column_null :information, :requirement, false, :default => ""
	change_column_null :information, :contact, false, :default => ""
	change_column_null :information, :image, false, :default => ""

  	change_column_null :guides, :type_id, false
  	change_column_null :guides, :industry_id, false
  	change_column_null :guides, :title, false, :default => ""
  	change_column_null :guides, :content, false, :default => ""
  	change_column_null :guides, :image, false, :default => ""

  	add_index :users, :openid, :unique => true
  	change_column_null :users, :openid, false, :default => ""
  	change_column_null :users, :nickname, false, :default => "微信用户"

  end
end
