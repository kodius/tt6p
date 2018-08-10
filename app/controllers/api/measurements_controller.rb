class Api::MeasurementsController < Api::ApiController

  def index
    @measurements = Measurement.where("user_id = ?", current_user.id).order('log_date desc')
  end

end
