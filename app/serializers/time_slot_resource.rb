class TimeSlotResource < BaseResource
  attributes :id, :start_time, :end_time

  attribute :day_of_week, &:day_of_week_before_type_cast
end
