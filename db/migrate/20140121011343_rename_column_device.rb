class RenameColumnDevice < ActiveRecord::Migration
  def change
		rename_column :devices, :type, :os_type
  end
end
