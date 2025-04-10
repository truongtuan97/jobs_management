class AddIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :age
  end
end
