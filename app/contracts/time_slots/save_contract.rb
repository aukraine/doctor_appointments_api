module TimeSlots
  class SaveContract < BaseContract
    option :time_slot, optional: true

    MIN_TIME_SLOT_SIZE = 15.minutes.to_i

    rule do
      start_time = values[:start_time].presence || time_slot.start_time
      end_time = values[:end_time].presence || time_slot.start_time
      time_slot_size = end_time - start_time

      if time_slot_size < MIN_TIME_SLOT_SIZE
        key('start_time & end_time').failure('Size of time slot must be greater than 15 minutes')
      end

      if start_time >= end_time
        key('start_time & end_time').failure('Value of end_time must be greater than start one')
      end
    end
  end
end
