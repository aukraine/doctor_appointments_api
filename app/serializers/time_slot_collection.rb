class TimeSlotCollection < TimeSlotResource
  one :doctor, resource: UserResource
end
