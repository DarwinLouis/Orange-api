class ChangeColumnBranchIdItems < ActiveRecord::Migration
  def change
		change_column :items, :branch_id, 'integer USING CAST(branch_id AS integer)'
  end
end
