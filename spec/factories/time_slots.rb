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
FactoryBot.define do
  factory :time_slot do
    doctor { create(:user, :doctor) }
    day_of_week { TimeSlot::MON }
    start_time { Time.current }
    end_time { start_time + 20.minutes }
    open

    trait :open do
      status { 'open' }
    end

    trait :booked do
      status { 'booked' }
    end
  end
end
