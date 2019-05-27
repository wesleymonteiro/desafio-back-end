class CreateFinances < ActiveRecord::Migration[5.1]
  def change
    create_table :finances do |t|
      t.integer :kind
      t.datetime :movement_datetime
      t.float :value
      t.integer :cpf
      t.integer :card_number
      t.string :store_owner_name
      t.string :store_name

      t.timestamps
    end
  end
end
