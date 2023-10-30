module TimeSlots
  class UpdateContract < SaveContract
    params do
      optional(:day_of_week).filled(:integer)
      optional(:start_time).filled(:time)
      optional(:end_time).filled(:time)
    end
  end
end
