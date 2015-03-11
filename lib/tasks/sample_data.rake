namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Patrick",
                 email: "patrick@oatdog.club",
                 password: "password",
                 password_confirmation: "password",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@oatdog.club"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end