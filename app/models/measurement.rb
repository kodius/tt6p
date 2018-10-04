class Measurement < ApplicationRecord
  belongs_to :user
  validates_presence_of :log_date
  validates_presence_of :user_id
  mount_uploader :image, ImageUploader

  before_save :set_success, :set_chart_data

  def self.chart_data(average_item, args={})
    set_query_filters(args)
    base_query(average_item)
  end

  def lbm
    if body_fat.present? && weight.present?
      (weight * (1 - body_fat/100.0)).round(1)
    else
      nil
    end
  end

  def set_success
    plan = Plan.where("user_id = ?", user_id).first
    if calories.present?
      if calories <= plan.total_calories
        self.success = true
      else
        #check last week if we are still below calorie wise 
        #make it success
        measurement_date = self.log_date
        last_week = Measurement.where("user_id = ? and log_date < ?", user_id, measurement_date).
          where.not(calories: nil).
          order("log_date desc").
          limit(7).
          pluck(:calories) || []
        last_week = last_week << calories
        if last_week.count > 0
          average = last_week.reduce(:+)/last_week.count.to_f
          if average < plan.total_calories
            self.success = true
          else
            self.success = false
          end
        else
          self.success = false
        end
      end
    end
  end

  def set_chart_data
    if log_date.present?
      self.week_num, self.month_num, self.year_num = log_date.strftime('%W %m %Y').split(' ')
    end
  end

  private

  def self.base_query(average_item)
    return nil if @filter.blank?

    user = User.find_by_id(@user_id) || current_user
    result = user.measurements.
      where(@filter.to_sym => @from..@to).
      group(@filter.to_sym).
      order(@filter.to_sym).
      average(average_item)
    result.each_pair do |key, value|
      result[key] = value&.round(1) || 0
    end

  end

  def self.set_query_filters opts
    opts.each { |k,v| instance_variable_set("@#{k}", v) }
  end

end
