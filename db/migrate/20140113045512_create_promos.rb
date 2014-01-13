class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :name
      t.string :description
      t.integer :branch_id

      t.timestamps
    end
  end
end
