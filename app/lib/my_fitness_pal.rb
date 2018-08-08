require 'csv'

class MyFitnessPal
  def self.import_measurements(user_id, file_name)
    data = CSV.read(file_name, headers: true)
    start_date = DateTime.parse(data[0][0])
    end_date = DateTime.parse(data[-1][0])
    Measurement.where("(log_date between ? AND ?) and user_id = ?", start_date, end_date, user_id).delete_all
    data.each do |data_row|
      Measurement.new(user_id: user_id, log_date: DateTime.parse(data_row[0]), weight: data_row['Weight']).save
    end
  end

  def self.import_nutrition(user_id, file_name)
    data = CSV.read(file_name, headers: true)
    start_date = DateTime.parse(data[0][0])
    end_date = DateTime.parse(data[-1][0])
    Nutrition.where("(log_date between ? AND ?) and user_id = ?", start_date, end_date, user_id).delete_all
    data.each do |data_row|
      Nutrition.new(user_id: user_id,
                    log_date: DateTime.parse(data_row[0]),
                    meal: data_row['Meal'],
                    calories: data_row['Calories'],
                    fat: data_row['Fat (g)'],
                    protein: data_row['Protein (g)'],
                    carbohydrates: data_row['Carbohydrates (g)'],
                    note: data_row['Note']).save
    end
  end
end
