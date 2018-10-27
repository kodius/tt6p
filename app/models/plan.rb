class Plan < ApplicationRecord
  belongs_to :user
  has_many :measurements, through: :user

  def lean_body_mass
    (weight * (1 - body_fat / 100.0)).round(1)
  end

  def last_lean_body_mass
    (last_weight * (1 - last_body_fat / 100.0)).round(1)
  end

  def target_lean_body_mass
    (lean_body_mass * 0.97).round(2)
  end

  def target_weight
    (100 * (last_lean_body_mass / (100 - target_body_fat))).floor
  end

  def tdee
    TDEECalculator.tdee(last_weight, height, age, gender, activity_level)
  end

  def total_calories
    (tdee * 0.8).ceil
  end

  def day_of_sixpack
    DateTime.now + days_till_sixpack.days
  end

  def days_till_sixpack
    result = ((last_weight - target_weight) * 7000 / (tdee - total_calories)).ceil
    result > 0 ? result : 0
  end

  def weight_change
    weight - last_weight
  end

  def total_deficit
    Measurement.where('user_id =?', user_id).order('log_date desc').sum('target_calories - calories').floor
  end

  def weight_change_expected
    (total_deficit / 7500).round(1)
  end

  def weekly_average
    start_date_measurement = Measurement.where('user_id =?', user_id).order('log_date asc').first
    if start_date_measurement
      days = (Date.today - start_date_measurement.log_date.to_date).to_i
      (weight_change / (days / 7)).round(1)
    else
      0
    end
  end

  def awards
    Awards.get_all[self.id] || []
  end

  def days_tracked
    Measurement.where('user_id =?', user_id).order('log_date desc').count
  end

  def days_streak
    measurement = Measurement.where('user_id =?', user_id).order('log_date desc').first
    if measurement
      current_day = measurement.log_date
    else
      current_day = DateTime.now.to_date - 1.day
    end
    count = 0
    Measurement.where('user_id = ? and (success is null or success is true)', user_id).order('log_date desc').each do |m|
      if m.log_date == current_day + 1.day
        next
      elsif m.log_date == current_day
        current_day = current_day - 1.day
        count += 1
      else
        break
      end
    end
    count
  end

  def fat_lost
    (weight * body_fat / 100.0 - last_weight * last_body_fat / 100.0).round(1)
  end

  def fat_mass
    (last_weight * last_body_fat / 100.0).round(1)
  end

  def lbm_diff
    (last_weight * (1 - last_body_fat / 100.0) - weight * (1 - body_fat / 100.0)).round(1)
  end

  # if we have measurments use latest, otherwise use the one from the plan
  def last_weight
    measurement = Measurement.where('user_id = ?', user_id).order('log_date desc').first
    measurement&.weight || weight
  end

  def last_body_fat
    measurement = Measurement.where('user_id = ?', user_id).order('log_date desc').first
    measurement&.body_fat || body_fat
  end
end
