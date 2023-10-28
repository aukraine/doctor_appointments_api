class ErrorHandler
  class << self
    def call(error) = detect_error(error)

    private

    def detect_error(error)
      case error
      when Errors::Base
        error
      when ActiveRecord::RecordNotFound
        Errors::NotFound.new
      when ActiveRecord::RecordNotUnique
        Errors::UnprocessableEntity.new
      when ArgumentError
        Errors::BadRequest.new
      when Pundit::NotAuthorizedError
        Errors::Forbidden.new
      else
        Errors::InternalServerError.new(error)
      end
    end
  end
end
