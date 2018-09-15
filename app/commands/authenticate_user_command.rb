class AuthenticateUserCommand < BaseCommand
  private

  attr_reader :email, :password

  def initialize(email, password, remember_me)
    @email = email
    @password = password
    @remember_me = remember_me
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def password_valid?
    user && user.valid_password?(password)
  end

  def payload
    if password_valid?
      @result = JwtService.encode(contents)
    else
      errors.add(:base, 'Invalid authentification')
    end
  end

  def contents
    if @remember_me
      {
        user_id: user.id,
        expiration: 10.years.from_now.to_i
      }
    else
      {
        user_id: user.id,
        expiration: 24.hours.from_now.to_i
      }
    end
  end
end
