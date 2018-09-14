class Api::MeasurementsController < Api::ApiController

  def index
    @measurements = Measurement.where("user_id = ?", current_user.id)
    @count = @measurements.count()
    @measurements = @measurements.order('log_date desc').offset((params[:page].to_i - 1) * 20).limit(20)
  end

  def public_measurements
    plan = Plan.find(params[:id])
    @measurements = Measurement.where("user_id = ?", plan.user_id).order('log_date desc')
    @count = @measurements.count()
    pp 'kurac'
    pp params
    @measurements = @measurements.order('log_date desc').offset((params[:page].to_i - 1) * 20).limit(20)
  end

  def create
    begin
      @measurement = Measurement.find(measurement_params['id'])
      @measurement.update(measurement_params)
      log_date = (@measurement.log_date + 2.hours).to_date
      @measurement.log_date = log_date
      @measurement.user = current_user
      @measurement.save!
    rescue ActiveRecord::RecordNotFound
      @measurement = Measurement.new(measurement_params)
      log_date = (@measurement.log_date + 2.hours).to_date
      @measurement.log_date = log_date
      @measurement.user = current_user
      Measurement.where("user_id = ? and log_date = ?", @measurement.user_id, log_date).delete_all
      @measurement.save!
    end
  end

  def destroy
    Measurement.delete(params[:id])
  end

  def image_upload
    @measurement = Measurement.where("user_id = ? and log_date = ?", current_user, params[:log_date].to_date).first

    @measurement.image = params[:image]
    @measurement.save!
  end

  def new 
    last_measurement = Measurement.where('user_id = ?', current_user.id).order("log_date desc").first 
    if last_measurement && last_measurement.log_date == DateTime.now.to_date
      @measurement = last_measurement
    else
      @measurement = Measurement.new
      if last_measurement
        @measurement.weight = last_measurement.weight
        @measurement.body_fat = last_measurement.body_fat
      end
      @measurement.log_date = DateTime.now.to_date
    end
  end

  def measurement_params
    params.require('measurement').permit(:id, :body_fat, :weight, :log_date, :calories)
  end

end
