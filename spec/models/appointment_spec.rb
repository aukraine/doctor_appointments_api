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
require 'rails_helper'

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
