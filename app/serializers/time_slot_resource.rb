class TimeSlotResource < BaseResource
  attributes :id, :status

  formatted_time_attributes :start_time, :end_time

  attribute :day_of_week, &:day_of_week_before_type_cast
end
