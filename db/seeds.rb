User.create!(name: "Vic the Admin",
             email: "vic@admin.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

100.times do |num|
  name = Faker::Name.name
  email = "test-#{num + 1}@liltwitter.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
