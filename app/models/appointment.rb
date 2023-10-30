# == Schema Information
#
# Table name: appointments
#
#  id           :integer          not null, primary key
#  description  :string
#  end_time     :datetime         not null
#  start_time   :datetime         not null
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

  private

  def no_overlapping_time_slots
    overlapped =
      Appointment
        .where.not(id: id)
        .where(patient_id: patient_id)
        .where(
          '(start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?) OR (start_time >= ? AND end_time <= ?)',
          end_time, start_time, start_time, end_time, start_time, end_time
        )
        .exists?

    errors.add(:base, 'Time slots cannot overlap') if overlapped
  end
end
