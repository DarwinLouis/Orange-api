class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.datetime :expiration_date
      t.string :card_no
      t.integer :user_id

      t.timestamps
    end
  end
end
