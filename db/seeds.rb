User.delete_all
Musician.delete_all
Plan.delete_all

User.create!(email: "admin@domain.com", password: "password", password_confirmation: "password", id: 1)
Musician.create!(name: "John Lennon", band: "beatles")
Musician.create!(name: "Paul McCartney", band: "beatles")
Musician.create!(name: "Georges Harrison", band: "beatles")
Musician.create!(name: "Ringo Starr", band: "beatles")
Musician.create!(name: "Mick Jagger", band: "rolling_stones")
Musician.create!(name: "Keith Richards", band: "rolling_stones")
Musician.create!(name: "Mick Taylor", band: "rolling_stones")
Musician.create!(name: "Bill Wyman", band: "rolling_stones")
Musician.create!(name: "Charlie Watts", band: "rolling_stones")
Musician.create!(name: "Angus Young", band: "acdc")
Musician.create!(name: "Malcom Young", band: "acdc")
Musician.create!(name: "Bon Scott", band: "acdc")
Musician.create!(name: "Phil Rudd", band: "acdc")

Plan.create(user_id: User.last.id, weight: 100, :body_fat => 25, target_body_fat: 13, height: 183, age: 41, gender: 'man', activity_level: 'moderatly_active' )

MyFitnessPal.import_measurements(User.last.id, File.expand_path('../../test/fixtures/measurements_test_data.csv', __FILE__) )
MyFitnessPal.import_nutrition(User.last.id, File.expand_path('../../test/fixtures/nutrition_test_data.csv', __FILE__) )
