module TimeSlots
  class CreateContract < SaveContract
    params do
      required(:day_of_week).filled(:integer)
      required(:start_time).filled(:time)
      required(:end_time).filled(:time)
    end
  end
end
