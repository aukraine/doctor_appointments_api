class RemoveStartTimeAndEndTimeFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :start_time, :timestamp, null: false
    remove_column :appointments, :end_time, :timestamp, null: false
  end
end
