json.plan do 
  json.id @plan.id
  json.createdAt l(@plan.created_at, format: :default)
  json.weight @plan.weight
  json.lastWeight @plan.last_weight
  json.bodyFat @plan.body_fat
  json.lastBodyFat @plan.last_body_fat
  json.targetBodyFat @plan.target_body_fat
  json.targetWeight @plan.target_weight
  json.targetLeanBodyMass @plan.target_lean_body_mass
  json.leanBodyMass @plan.lean_body_mass
  json.gender @plan.gender
  json.activityLevel @plan.activity_level
  json.tdee @plan.tdee
  json.totalCalories @plan.total_calories
  json.lbm @plan.lean_body_mass
  json.lastLbm @plan.last_lean_body_mass
  json.daysTillSixpack @plan.days_till_sixpack
  json.dayOfSixpack l(@plan.day_of_sixpack.to_date, format: :long)
  json.weightChange @plan.weight_change
  json.fatLost @plan.fat_lost
  json.fatMass @plan.fat_mass
  json.lbmDiff @plan.lbm_diff
  json.daysStreak @plan.days_streak
  json.awards @plan.awards.join(', ')
  json.email @plan.user.email
  json.userId @plan.user_id
end
