class AddBranchToItem < ActiveRecord::Migration
  def change
    add_column :items, :branch, :string
  end
end
