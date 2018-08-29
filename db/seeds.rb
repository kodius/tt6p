User.delete_all
Plan.delete_all

User.create!(email: "admin@domain.com", password: "password", password_confirmation: "password", id: 1)
User.create!(email: "user@kodius.io", password: "password", password_confirmation: "password", id: 2)

Plan.create(user_id: User.last.id, weight: 100, :body_fat => 25, target_body_fat: 13, height: 183, age: 41, gender: 'man', activity_level: 'moderatly_active' )

MyFitnessPal.import_measurements(User.last.id, File.expand_path('../../test/fixtures/measurements_test_data.csv', __FILE__) )
MyFitnessPal.import_nutrition(User.last.id, File.expand_path('../../test/fixtures/nutrition_test_data.csv', __FILE__) )
