class Api::EntryController < Api::ApiController
  def show
    @date = params[:date]

    @nutrition = Nutrition.where('user_id = ? AND log_date = ?', current_user.id, @date).first
    @measurements = Measurement.where('user_id = ? AND log_date = ?', current_user.id, @date).first

    pp @nutrition
    pp @measurements
  end
end