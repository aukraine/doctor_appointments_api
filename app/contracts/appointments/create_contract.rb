module Appointments
  class CreateContract < BaseContract
    params do
      required(:time_slot_id).filled(:integer)
      optional(:description).filled(:string)
    end
  end
end
