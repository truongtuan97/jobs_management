class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      # t.string :password_digest
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
