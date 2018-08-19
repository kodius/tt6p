json.measurement do
  json.id @measurement.id
  json.weight @measurement.weight
  json.bodyFat @measurement.body_fat
  json.calories @measurement.calories
  json.logDate @measurement.log_date
end
