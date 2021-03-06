class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :disbursement_tx
      t.integer :user_id
      t.integer :amount_id
      t.integer "purchasable_id"
      t.string  "purchasable_type"
      t.timestamps
    end
  end
end
