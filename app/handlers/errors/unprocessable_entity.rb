module Errors
  class UnprocessableEntity < Base
    def status_code  = 422
    def simple_error = 'The record with specified attributes could not be processed.'
  end
end
