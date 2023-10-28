class CreateDoctorAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_availabilities do |t|
      t.references :doctor, null: false, foreign_key: { to_table: :users }, index: true
      t.integer :start_time, null: false
      t.integer :end_time, null: false
      t.integer :day_of_week, null: false, default: 0

      t.timestamps
    end
  end
end
