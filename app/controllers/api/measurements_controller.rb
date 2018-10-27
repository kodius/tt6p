class Api::MeasurementsController < Api::ApiController
  def index
    @measurements = Measurement.where('user_id = ?', current_user.id)
    @count = @measurements.count()
    @measurements = @measurements.order('log_date desc').offset((params[:page].to_i - 1) * 20).limit(20)
  end

  def public_measurements
    plan = Plan.find(params[:id])
    @measurements = Measurement.where('user_id = ?', plan.user_id).order('log_date desc')
    @count = @measurements.count()
    @measurements = @measurements.order('log_date desc').offset((params[:page].to_i - 1) * 20).limit(20)
  end

  def chart_data
    return {} unless params.fetch(:dimension)

    user = Plan.find_by_id(params[:id]).try(:user) || current_user
    from = params[:from] || 15.weeks.ago.strftime('%W')
    to = params[:to] || Time.now.strftime('%W')
    dimension = params[:dimension] + '_num'

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
    measurement = Measurement.find_by_id(measurement_params['id'])
    params[:measurement].delete :id
    new_measurement = Measurement.new(measurement_params)
    log_date = (new_measurement.log_date + 2.hours).to_date

    #this will be used if no log is found
    new_measurement.log_date = log_date
    new_measurement.user = current_user

    if measurement.blank?
      measurement = Measurement.where('log_date = ? and user_id = ?', log_date, current_user.id).first || new_measurement
    else
      #promjenili smo dan ili treba naci taj log ili napraviti novi
      if measurement.log_date != log_date
        measurement = Measurement.where('log_date = ? and user_id = ?', log_date, current_user.id).first || new_measurement
      end
    end

    measurement.update(measurement_params)
    measurement.log_date = log_date
    measurement.save!
    render json: {id: measurement.id}
  end

  def destroy
    Measurement.delete(params[:id])
  end

  #ovdje je ostao bug - kad se promijeni datum treba dohvatiti taj log ako ima ili dodati novi
  #slicno kao i za ovaj gore create
  #to mozemo napraviti tako da se kod logiranja vrati ID koji smo dobili i onda se on dalje salje za upload slike
  def image_upload
    measurement = Measurement.find_by_id(params[:measurement_id])

    if measurement
      measurement.image = params[:image]
      measurement.save!
    end
  end

  def new
    # popraviti da koristi vremensku zonu klijenta
    last_measurement = Measurement.where('user_id = ? and log_date = ?', current_user.id, DateTime.now.to_date).first
    if last_measurement
      @measurement = last_measurement
    else
      last_measurement = Measurement.where('user_id = ?', current_user.id).order('log_date desc').first
      @measurement = Measurement.new
      @measurement.user = current_user
      if last_measurement
        @measurement.weight = last_measurement.weight
        @measurement.body_fat = last_measurement.body_fat
      end
      @measurement.log_date = DateTime.now.to_date
      @measurement.save!
    end
  end

  def measurement_params
    params.require('measurement').permit(:id, :body_fat, :weight, :log_date, :calories)
  end
end
