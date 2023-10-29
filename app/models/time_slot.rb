# == Schema Information
#
# Table name: time_slots
#
#  id          :integer          not null, primary key
#  day_of_week :integer          default("Monday"), not null
#  end_time    :integer          not null
#  start_time  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  doctor_id   :integer          not null
#
# Indexes
#
#  index_time_slots_on_doctor_id  (doctor_id)
#
# Foreign Keys
#
#  doctor_id  (doctor_id => users.id)
#
class TimeSlot < ApplicationRecord
  DAYS_OF_WEEK = {
    MON = 'Monday'.freeze => 0,
    TUE = 'Tuesday'.freeze => 1,
    WED = 'Wednesday'.freeze => 2,
    THO = 'Thursday'.freeze => 3,
    FRI = 'Friday'.freeze => 4,
    SAT = 'Saturday'.freeze => 5,
    SUN = 'Sunday'.freeze => 6
  }

  belongs_to :doctor

  enum day_of_week: DAYS_OF_WEEK, _default: DAYS_OF_WEEK[MON]

  validate :no_overlapping_time_slots

  private

  def no_overlapping_time_slots
    overlapped =
      TimeSlot
        .where.not(id: id) # Exclude the current record if it's being updated
        .where(doctor_id: doctor_id)
        .where(
          '(start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?) OR (start_time >= ? AND end_time <= ?)',
          end_time, start_time, start_time, end_time, start_time, end_time
        )
        .exists?
      # there is SQL 'OVERLAPS' function but is not supported on SQLite
      # .where('(start_time, end_time) OVERLAPS (?, ?)', start_time, end_time)

    errors.add(:base, 'Time slots cannot overlap') if overlapped
  end
end
