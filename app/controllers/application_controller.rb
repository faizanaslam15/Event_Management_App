class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = ::JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
  rescue
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
