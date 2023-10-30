class ChangeAppointmentsAndTimeSlotsModels < ActiveRecord::Migration[7.0]
  def change
    add_column :time_slots, :status, :string, null: false, default: 'open'
    change_column :appointments, :start_time, :timestamp, null: false
    change_column :appointments, :end_time, :timestamp, null: false
    remove_index :appointments, [:start_time, :end_time]
    add_reference :appointments, :patient, foreign_key: { to_table: :users }, null: true, index: true
    add_reference :appointments, :time_slot, foreign_key: true, null: true, index: true
    add_column :appointments, :description, :string, null: true, default: nil
    add_column :appointments, :status, :string, null: false, default: 'booked'
  end
end
