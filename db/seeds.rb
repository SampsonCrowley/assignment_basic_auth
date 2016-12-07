puts 'creating users'
5.times do
  User.create(
    username: Faker::Hipster.word,
    email: Faker::Internet.email,
    password_digest: Faker::Hipster.word)
end

User.create(
  username: 'user',
  email: 'user@foo.bar',
  password: 'password')
