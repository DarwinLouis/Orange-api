class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :claim_code
      t.string :status
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
