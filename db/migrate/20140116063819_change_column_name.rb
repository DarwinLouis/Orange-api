class ChangeColumnName < ActiveRecord::Migration
  def change
	  rename_column :credits, :brand_id, :branch_id
  end
end
