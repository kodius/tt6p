class Api::AuthsController < Api::ApiController
  skip_before_action :authenticate_user

  def create
    token_command = AuthenticateUserCommand.call(*params.slice(:email, :password, :remember_me).values)

    if token_command.success?
      user = User.find_by_email(params[:email])

      render json: { token: token_command.result, user: user }, status: 200
    else
      render json: { error: token_command.errors }, status: 422
    end
  end

  def verify_token
    user = DecodeAuthenticationCommand.call(request.headers).result

    render json: {user: user}, status: 200 if user
    render json: {}, status: 422 unless user
  end
end