# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Plane.destroy_all
City.destroy_all
Airport.destroy_all
Rental.destroy_all

# # planes
Plane.create!(model: "Bombardier Learjet 40 XR", identifier: "JWG-011", year_made: 1999, available: true, daily_cost: 3000)
Plane.create!(model: "Bombardier Learjet 70", identifier: "JWG-012", year_made: 2002, available: true, daily_cost: 4500)
Plane.create!(model: "Hawker Beechcraft 400", identifier: "JWG-013", year_made: 2008, available: true, daily_cost: 3800)
Plane.create!(model: "Cessna Citation CJ1", identifier: "JWG-014", year_made: 2012, available: true, daily_cost: 4800)
Plane.create!(model: "Cessna Citation XLS", identifier: "JWG-021", year_made: 2003, available: true, daily_cost: 5200)
Plane.create!(model: "Embraer Legacy 450", identifier: "JWG-022", year_made: 2007, available: true, daily_cost: 5500)
Plane.create!(model: "Gulfstream 250", identifier: "JWG-023", year_made: 2006, available: true, daily_cost: 6200)
Plane.create!(model: "Embraer Legacy 600", identifier: "JWG-031", year_made: 2002, available: true, daily_cost: 8150)
Plane.create!(model: "Bombardier Challenger 300", identifier: "JWG-032", year_made: 2011, available: true, daily_cost: 10000)

# # cities
City.create!(name: "Chicago", destinations: "Millenium Park, The Art Institute, Cloudgate")
City.create!(name: "New York City", destinations: "Times Square, Central Park, Flatiron Building")
City.create!(name: "London", destinations: "Buckingham Palace, Trafalgar's Square")
City.create!(name: "Tokyo", destinations: "Akihabara, Imperial Palace")
City.create!(name: "Paris", destinations: "The Louve, Versailles")

# airports
Airport.create!(name: "O'Hare", code: "ORD", city_id: 1)
Airport.create!(name: "Midway", code: "MDW", city_id: 1)
Airport.create!(name: "John F Kennedy", code: "JFK", city_id: 2)
Airport.create!(name: "LaGuardia", code: "LGA", city_id: 2)
Airport.create!(name: "Heathrow", code: "LHR", city_id: 3)
Airport.create!(name: "Gatwick", code: "LGW", city_id: 3)
Airport.create!(name: "Narita", code: "NRT", city_id: 4)
Airport.create!(name: "Haneda", code: "HND", city_id: 4)
Airport.create!(name: "Charles de Gaulle", code: "CDG", city_id: 5)


