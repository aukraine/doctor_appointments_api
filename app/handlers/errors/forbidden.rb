module Errors
  class Forbidden < Base
    def status_code  = 403
    def simple_error = 'The current user does not have access to perform the requested action.'
  end
end
