module Errors
  class Unauthorized < Base
    def status_code  = 401
    def simple_error = 'Unauthorized.'
  end
end
