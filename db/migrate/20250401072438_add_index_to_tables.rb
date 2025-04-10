class AddIndexToTables < ActiveRecord::Migration[7.1]
  def change
    add_index :doctors, :name
    add_index :doctors, :specialty

    add_index :patients, :name
    add_index :patients, :age

    add_index :appointments, %i[doctor_id patient_id], unique: true
    add_index :appointments, :appointment_date
    add_index :appointments, :status
  end
end
