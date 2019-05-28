class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :owner
      t.float :balance, default: 0

      t.timestamps
    end
  end
end
