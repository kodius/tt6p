class Plan < ApplicationRecord

  def lean_body_mass
    weight*(1-body_fat/100.0)
  end

  def target_lean_body_mass
    lean_body_mass*0.97
  end

  def target_weight
    target_lean_body_mass/(1 - target_body_fat/100.0)
  end
  
end
