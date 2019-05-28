class AddStoreToFinance < ActiveRecord::Migration[5.1]
  def change
    add_reference :finances, :store, foreign_key: true
  end
end
