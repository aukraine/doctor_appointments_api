class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.integer :start_time, null: false
      t.integer :end_time, null: false

      t.timestamps
    end

    add_index :appointments, [:start_time, :end_time]
  end
end
