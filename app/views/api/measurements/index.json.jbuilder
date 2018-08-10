json.measurements @measurements.each do |measurement|
  json.id measurement.id
  json.createdAt l(measurement.created_at, format: :default)
  json.weight measurement.weight
  json.userId measurement.user_id
  json.logDate l(measurement.log_date, format: :default)
end
