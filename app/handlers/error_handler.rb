class ErrorHandler
  class << self
    def call(error) = detect_error(error)

    private

    def detect_error(error)
      case error
      when Errors::Base
        error
      when ActiveRecord::RecordNotFound
        Errors::NotFound.new(error)
      when ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
        Errors::UnprocessableEntity.new(error)
      when ArgumentError
        Errors::BadRequest.new(error)
      when Pundit::NotAuthorizedError
        Errors::Forbidden.new
      else
        # we can do not pass error message to response body if we don't want to show any internal errors in clients
        Errors::InternalServerError.new(error)
      end
    end
  end
end
