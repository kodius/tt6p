json.measurements @measurements.each do |measurement|
  json.id measurement.id
  json.createdAt l(measurement.created_at, format: :default)
  json.weight measurement.weight
  json.bodyFat measurement.body_fat
  json.calories measurement.calories
  json.lbm measurement.lbm
  json.userId measurement.user_id
  json.success measurement.success
  json.logDate l(measurement.log_date.to_date, format: :default)
end
json.count @count
