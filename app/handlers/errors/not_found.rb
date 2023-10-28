module Errors
  class NotFound < Base
    def status_code  = 404
    def simple_error = 'The record with specified attributes is not found.'
  end
end
