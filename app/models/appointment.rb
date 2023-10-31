# == Schema Information
#
# Table name: appointments
#
#  id           :integer          not null, primary key
#  description  :string
#  status       :string           default("booked"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  patient_id   :integer
#  time_slot_id :integer
#
# Indexes
#
#  index_appointments_on_patient_id    (patient_id)
#  index_appointments_on_time_slot_id  (time_slot_id)
#
# Foreign Keys
#
#  patient_id    (patient_id => users.id)
#  time_slot_id  (time_slot_id => time_slots.id)
#
class Appointment < ApplicationRecord
  BOOKED_STATUS = 'booked'.freeze
  COMPLETED_STATUS = 'completed'.freeze
  CANCELED_STATUS = 'canceled'.freeze
  STATUSES = {  BOOKED_STATUS => BOOKED_STATUS, COMPLETED_STATUS => COMPLETED_STATUS, CANCELED_STATUS => CANCELED_STATUS }

  belongs_to :patient
  belongs_to :time_slot

  enum status: STATUSES, _default: BOOKED_STATUS

  validates :time_slot_id, uniqueness: { conditions: -> { where(status: BOOKED_STATUS) } }
  validate :no_overlapping_time_slots
  validate :start_time_cannot_be_in_past

  scope :upcoming_or_after, ->(date = Time.current) { joins(:time_slot).where('time_slots.start_time >= ?', date) }

  private

  def no_overlapping_time_slots
    overlapped =
      Appointment
        .where.not(id: id)
        .where(patient_id: patient_id)
        .joins(:time_slot)
        .where(
          '(time_slots.start_time < ? AND time_slots.end_time > ?) OR (time_slots.start_time < ? AND time_slots.end_time > ?) OR (time_slots.start_time >= ? AND time_slots.end_time <= ?)',
          time_slot.end_time, time_slot.start_time, time_slot.start_time, time_slot.end_time, time_slot.start_time, time_slot.end_time
        )
        .exists?

    errors.add(:base, 'Time slots cannot overlap') if overlapped
  end

  def start_time_cannot_be_in_past
    errors.add(:base, 'Start time can not be in the past') if time_slot.start_time < Time.current
  end
end
