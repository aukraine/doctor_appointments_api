module TimeSlots
  class ShowOpenContract < BaseContract
    params do
      optional(:started_from).filled(:time)
      optional(:doctor_id).filled(:integer)
    end
  end
end
