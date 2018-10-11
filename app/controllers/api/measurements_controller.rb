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
    @measurements = @measurements.order('log_date desc').offset((params[:page].to_i - 1) * 20).limit(20)
  end

  def chart_data
    return {} unless params.fetch(:dimension)

    user = Plan.find_by_id(params[:id]).try(:user) || current_user
    from = params[:from] || 15.weeks.ago.strftime("%W")
    to = params[:to] || Time.now.strftime("%W")
    dimension = params[:dimension] + "_num"

    if params[:average_on] == 'weight'
      @data = []
      @data[0] = Measurement.chart_data(params[:average_on], {filter: dimension, user_id: user.id, from: from, to: to})
      @data[1] = Measurement.chart_data(:lean_body_mass, {filter: dimension, user_id: user.id, from: from, to: to})
    else
      @data = []
      @data[0] = Measurement.chart_data(params[:average_on], {filter: dimension, user_id: user.id, from: from, to: to})
      @data[1] = Measurement.chart_data(:target_calories, {filter: dimension, user_id: user.id, from: from, to: to})
    end

    render json: @data
  end

  def create
    @measurement = Measurement.find_by_id(measurement_params['id'])
    if @measurement.blank?
      @measurement = Measurement.new(measurement_params)
      log_date = (@measurement.log_date + 2.hours).to_date
      @measurement.log_date = log_date
      @measurement.user = current_user
      #make sure to remove doubles - only one log date per user measurement is allowed
      Measurement.where("user_id = ? and log_date = ?", @measurement.user_id, log_date).delete_all
    else
      @measurement.update(measurement_params)
    end
    @measurement.save!
  end

  def destroy
    Measurement.delete(params[:id])
  end

  def image_upload
    measurement = Measurement.find_by_id(params[:measurement_id])

    if measurement
      measurement.image = params[:image]
      measurement.save!
    end
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
