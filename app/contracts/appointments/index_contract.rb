module Appointments
  class IndexContract < BaseContract
    params do
      optional(:started_from).filled(:time)
    end
  end
end
