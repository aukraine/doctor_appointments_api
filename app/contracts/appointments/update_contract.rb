module Appointments
  class UpdateContract < BaseContract
    params do
      optional(:time_slot_id).filled(:integer)
      optional(:description).filled(:string)
    end
  end
end
