class Plan < ApplicationRecord

  def lean_body_mass
    weight*(1-body_fat/100.0).round(2)
  end

  def target_lean_body_mass
    lean_body_mass*0.97.round(2)
  end

  def target_weight
    (target_lean_body_mass/(1 - target_body_fat/100.0)).round(2)
  end

  def tdee
    TDEECalculator.tdee(weight, height, age, gender, activity_level)
  end

  def total_calories
    (tdee*0.8).ceil
  end

  def days_till_sixpack
    ((weight - target_weight)*7000/(tdee - total_calories)).ceil
  end

end
