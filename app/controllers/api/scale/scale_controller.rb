class Api::Scale::ScaleController < Api::ApiController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  
  def auth
    response = 'authError'
    user = User.find_by_email(params[:email])
    if user
      if user.valid_password?(params[:password])
        crypt = ActiveSupport::MessageEncryptor.new(secret[0, 32], secret)
        response = crypt.encrypt_and_sign(user.id, expires_in: 1.month)
        @current_api_user = user
      end
    end
    
    render json: response, status: 200
  end

  def new
    if auth_api_user params[:token]
      @measurement = Measurement.new(log_date: Date.today, weight: params[:weight], body_fat: params[:body_fat])
      log_date = (@measurement.log_date + 2.hours).to_date
      @measurement.log_date = log_date
      @measurement.user = @current_api_user
      Measurement.where("user_id = ? and log_date = ?", @measurement.user_id, log_date).delete_all
      @measurement.save!
      render json: 'true', status: 200
    else
      render json: 'authError', status: 403
    end
  end

  def get
    if auth_api_user params[:token]
      measurements = Measurement.where("user_id = ?", @current_api_user.id).order('log_date desc').limit(5)
      measurements = measurements.pluck(:log_date, :weight, :body_fat)
      data = []

      measurements.each do |measurement|
        data << measurement.join('|')
      end

      render json: data.join('|'), status: 200
    else
      render json: 'authError', status: 403
    end
  end

  private

  def secret
    '05a89d17bd2b9918dfb2a505e95b718467b674bddc7def73e04f45ad1839ceaa9ffe9d39818331b53ef6377d03062e21df90588369f0d7f908d8ac95dc308f89'
  end

  def auth_api_user token
    crypt = ActiveSupport::MessageEncryptor.new(secret[0, 32], secret)
    user_id = crypt.decrypt_and_verify(token) rescue nil
    return false unless user_id
    @current_api_user = User.find(user_id)
    return true
  end
end