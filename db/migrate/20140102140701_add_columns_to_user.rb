class AddColumnsToUser < ActiveRecord::Migration
  def change
	add_column :users, :full_name, :string  
	add_column :users, :mobile_no, :string  
	add_column :users, :user_name, :string  
	add_column :users, :old_card_no, :string
  end
end
