puts "Doing reseed of data"
Plan.delete_all
User.delete_all
Measurement.delete_all

User.create!(email: "user@kodius.io", password: "password", password_confirmation: "password", id: 2)
puts "Reseed of data ended"

#MyFitnessPal.import_measurements(User.last.id, File.expand_path('../../test/fixtures/measurements_test_data.csv', __FILE__) )
#MyFitnessPal.import_nutrition(User.last.id, File.expand_path('../../test/fixtures/nutrition_test_data.csv', __FILE__) )
