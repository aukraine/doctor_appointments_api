class ApplicationController < ActionController::API
  include Pundit::Authorization

  before_action :authenticate, except: :login

  rescue_from StandardError do |exception|
    handle_exception(exception)
  end

  attr_reader :current_user, :resource

  def login
    auth_params = params.permit(:email, :password)
    user = User.find_by(email: auth_params[:email])

    if user&.authenticate(auth_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: token }, status: :ok
    else
      render_error(Errors::Unauthorized.new('Invalid credentials.'))
    end
  end

  private

  def authenticate
    header = request.headers['Authorization']
    header = header.split(' ').last if header.present?

    if header.present? && (decoded = JsonWebToken.decode(header))
      @current_user = User.find(decoded[:user_id])
    else
      render_error(Errors::Unauthorized.new)
    end
  end

  def handle_exception(exception)
    prepared_error = ErrorHandler.(exception)

    # we can provide more details into logs for better troubleshooting
    Rails.logger.error("[ERROR] [#{prepared_error}] #{prepared_error.error_detail}")

    render_error(prepared_error, prepared_error.status_code)
  end

  def render_error(error, status = nil)
    render json: { error: error.error_detail }, status: status.presence || error.status_code
  end
end
