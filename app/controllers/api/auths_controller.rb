class Api::AuthsController < Api::ApiController
  skip_before_action :authenticate_user

  def create
    token_command = AuthenticateUserCommand.call(*params.slice(:email, :password, :remember_me).values)

    if token_command.success?
      render json: { token: token_command.result }
    else
      render json: { error: token_command.errors }
    end
  end
end