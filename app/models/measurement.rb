class Measurement < ApplicationRecord
  belongs_to :user
  validates_presence_of :log_date
  validates_presence_of :user_id
  mount_uploader :image, ImageUploader

  before_save :set_success

  def self.by_week
    base_query({filter: "week_num", from: 30, to: 40, user_id: 9})
  end

  def self.by_month user_id=nil
    base_query({filter: "month_num", from: 1, to: 12, user_id: 9})
  end

  def self.by_year; end

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

  private

  def self.base_query opts={}
    return nil if opts.values_at(:filter, :from, :to).any?(&:blank?)
    return nil unless self.column_names.include?(opts[:filter])
    set_query_filters(opts)

    current_user ||= User.find_by_id(opts[:user_id])
    current_user.measurements.
      where(@filter.to_sym => @from..@to).
      group(@filter.to_sym).
      order(@filter.to_sym).
      average(:calories)
  end

  def self.set_query_filters opts
    opts.each { |k,v| instance_variable_set("@#{k}", v) }
  end

end
