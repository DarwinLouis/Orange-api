class RenameColumnItems < ActiveRecord::Migration
  def change
		rename_column :items, :branch, :branch_id
  end
end
