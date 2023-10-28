module Errors
  class BadRequest < Base
    def status_code  = 400
    def simple_error = 'The request cannot be completed.'
  end
end
