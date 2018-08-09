json.plans @plans.each do |plan|
  json.id plan.id
  json.createdAt l(plan.created_at, format: :default)
  json.weight plan.weight
  json.bodyFat plan.body_fat
  json.targetBodyFat plan.target_body_fat
  json.targetWeight plan.target_weight
  json.targetLeanBodyMass plan.target_lean_body_mass
  json.leanBodyMass plan.lean_body_mass
  json.gender plan.gender
  json.activityLevel plan.activity_level
  json.tdee plan.tdee
  json.totalCalories plan.total_calories
  json.lbm plan.lean_body_mass
  json.daysTillSixpack plan.days_till_sixpack
end