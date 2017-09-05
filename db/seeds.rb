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

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user = users.first
following = users[3..40]
followers = users[5..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
