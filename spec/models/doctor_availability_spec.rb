# == Schema Information
#
# Table name: doctor_availabilities
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
#  index_doctor_availabilities_on_doctor_id  (doctor_id)
#
# Foreign Keys
#
#  doctor_id  (doctor_id => users.id)
#
require 'rails_helper'

RSpec.describe DoctorAvailability, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
