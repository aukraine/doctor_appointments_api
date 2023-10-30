class AppointmentResource < BaseResource
  attributes :id, :description, :status

  formatted_time_attributes :start_time, :end_time

  one :time_slot, resource: TimeSlotResource
end
