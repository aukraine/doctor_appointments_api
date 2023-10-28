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
class DoctorAvailability < ApplicationRecord
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
end
