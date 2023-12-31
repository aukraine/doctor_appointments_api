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
require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  subject { FactoryBot.create(:time_slot) }

  describe 'associations' do
    it { is_expected.to belong_to(:doctor) }
    it { is_expected.to have_one(:appointment) }
  end
end
