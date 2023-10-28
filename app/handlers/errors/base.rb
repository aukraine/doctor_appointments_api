module Errors
  class Base < StandardError
    attr_reader :errors

    def initialize(errors = {})
      @errors = errors
    end

    def error_detail
      errors.presence || simple_error
    end

    def status_code
      500
    end

    def detail_message(default)
      message == self.class.name ? default : message
    end

    def simple_error
      'An error has occurred on the backend.'
    end
  end
end
