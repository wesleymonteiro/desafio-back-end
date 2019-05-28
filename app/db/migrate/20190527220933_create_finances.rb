class CreateFinances < ActiveRecord::Migration[5.1]
  def change
    create_table :finances do |t|
      t.integer :kind
      t.datetime :movement_datetime
      t.float :value
      t.string :cpf
      t.string :card_number

      t.timestamps
    end
  end
end
