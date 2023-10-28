module DoctorAvailabilities
  class CreateContract < BaseContract
    params do
      required(:day_of_week).filled(:integer)
      required(:start_time).filled(:integer)
      required(:end_time).filled(:integer)
    end
  end
end
