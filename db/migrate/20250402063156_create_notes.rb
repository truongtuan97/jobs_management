class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.text :body
      t.references :noteable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
