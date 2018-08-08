require 'csv'

class MyFitnessPal
  def self.import_measurements(user_id, file_name)
    data = CSV.read(file_name, headers: true)
    start_date = DateTime.parse(data[0][0])
    end_date = DateTime.parse(data[-1][0])
    Measurement.where("(date_of_measurement between ? AND ?) and user_id = ?", start_date, end_date, user_id).delete_all
    data.each do |data_row|
      Measurement.new(user_id: user_id, date_of_measurement: DateTime.parse(data_row[0]), weight: data_row[1]).save
    end
  end
end
