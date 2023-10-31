# == Schema Information
#
# Table name: time_slots
#
#  id          :integer          not null, primary key
#  day_of_week :integer          default("Monday"), not null
#  end_time    :datetime         not null
#  start_time  :datetime         not null
#  status      :string           default("open"), not null
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
  STATUSES = { OPEN_STATUS = 'open'.freeze => 'open'.freeze, BOOKED_STATUS = 'booked'.freeze => 'booked'.freeze }

  belongs_to :doctor
  has_one :appointment

  enum day_of_week: DAYS_OF_WEEK, _default: MON
  enum status: STATUSES, _default: OPEN_STATUS

  validate :no_overlapping_time_slots
  validate :start_time_cannot_be_in_past

  scope :open, -> { where(status: OPEN_STATUS) }
  scope :upcoming_or_after, ->(date = Time.current) { where('start_time >= ?', date) }

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

  def start_time_cannot_be_in_past
    errors.add(:base, 'Start time can not be in the past') if start_time < Time.current
  end
end
