# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  end_time   :integer          not null
#  start_time :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_appointments_on_start_time_and_end_time  (start_time,end_time)
#
require 'rails_helper'

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
