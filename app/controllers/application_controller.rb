class ApplicationController < ActionController::API
  before_action :authenticate, except: :login

  def login
    auth_params = params.permit(:email, :password)
    user = User.find_by(email: auth_params[:email])

    if user&.authenticate(auth_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def authenticate
    header = request.headers['Authorization']
    header = header.split(' ').last if header.present?

    if header.present? && (decoded = JsonWebToken.decode(header))
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end
end
