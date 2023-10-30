module TimeSlots
  class SaveContract < BaseContract
    option :time_slot, optional: true

    MIN_TIME_SLOT_SIZE = 15.minutes.to_i

    rule do
      next if time_slot.blank? && [:start_time, :end_time].any? { |key| values.keys.exclude?(key) }

      start_time = values[:start_time].presence || time_slot.start_time
      end_time = values[:end_time].presence || time_slot.end_time

      if end_time - start_time < MIN_TIME_SLOT_SIZE
        key('start_time & end_time').failure('Size of time slot must be greater than 15 minutes')
      end

      if start_time >= end_time
        key('start_time & end_time').failure('Value of end_time must be greater than start one')
      end
    end
  end
end
