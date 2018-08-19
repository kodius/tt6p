class Api::MeasurementsController < Api::ApiController

  def index
    @measurements = Measurement.where("user_id = ?", current_user.id).order('log_date desc')
  end

  def create  
    @measurement = Measurement.new(measurement_params)
    log_date = @measurement.log_date.to_date
    @measurement.log_date = (@measurement.log_date + 2.hours).to_date
    @measurement.user = current_user
    @measurement.save!
  end

  def new 
    last_measurement = Measurement.where('user_id = ?', current_user.id).order("log_date desc").first 
    @measurement = Measurement.new
    if last_measurement
      @measurement.weight = last_measurement.weight
      @measurement.body_fat = last_measurement.body_fat
      @measurement.calories = nil
    end
    @measurement.log_date = DateTime.now
  end

  def measurement_params
    params.require('measurement').permit(:body_fat, :weight, :log_date, :calories)
  end

end
