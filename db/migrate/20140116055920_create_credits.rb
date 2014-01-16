class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.string :reference_no
      t.decimal :amount , :precision => 8, :scale => 2
      t.integer :point
      t.integer :membership_id
      t.integer :brand_id

      t.timestamps
    end
  end
end
