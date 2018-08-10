class Plan < ApplicationRecord

  def lean_body_mass
    weight*(1-body_fat/100.0).round(2)
  end

  def target_lean_body_mass
    (lean_body_mass*0.97).round(2)
  end

  def target_weight
    (target_lean_body_mass/(1 - target_body_fat/100.0)).floor
  end

  def tdee
    TDEECalculator.tdee(weight, height, age, gender, activity_level)
  end

  def total_calories
    (tdee*0.8).ceil
  end

  def day_of_sixpack
    DateTime.now + days_till_sixpack.days
  end

  def days_till_sixpack
    #if we have measurments use latest, otherwise use the one from the plan
    measurement =  Measurement.where('user_id = ?', user_id).order('log_date desc').first
    last_weigth = measurement&.weight || weight
    result = ((last_weigth - target_weight)*7000/(tdee - total_calories)).ceil
    result > 0 ? result : 0
  end

end
