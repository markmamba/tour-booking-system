puts "Seeding database..."

# Create a Driver
driver = Identities::User.create!(
  first_name: "Taro",
  last_name: "Tanaka",
  email: "driver@example.com",
  password: "password123",
  vehicle_type: "Toyota Alphard",
  vehicle_plate_number: "Shinagawa 500 A 1234"
)

puts "Seeded Driver: #{driver.email} / password123"