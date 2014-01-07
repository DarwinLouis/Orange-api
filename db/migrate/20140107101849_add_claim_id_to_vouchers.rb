class AddClaimIdToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :claim_id, :string
  end
end
