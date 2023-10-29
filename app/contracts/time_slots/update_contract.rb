module TimeSlots
  class UpdateContract < SaveContract
    params do
      optional(:day_of_week).filled(:integer)
      optional(:start_time).filled(:integer)
      optional(:end_time).filled(:integer)
    end
  end
end
