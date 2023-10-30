class ChangeStartTimeAndEndTimeToBeTimestampInTimeSlots < ActiveRecord::Migration[7.0]
  def change
    change_column :time_slots, :start_time, :timestamp, null: false
    change_column :time_slots, :end_time, :timestamp, null: false
  end
end
