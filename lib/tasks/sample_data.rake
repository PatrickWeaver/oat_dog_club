namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_zines
    make_authorships
  end
end


def make_users
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

def make_zines
  30.times do |n|
    title = Faker::Lorem.words[1]
    Zine.create!(title: title,
                  published: true )
  end
end

def make_authorships
  users = User.all
  zines = Zine.all
  10.times do |n|
    user = User.find(n+1)
    zine1 = Zine.find(n+1)
    zine2 = Zine.find(n+2)
    zine3 = Zine.find(n+3)
    user.become_author!(zine1)
    user.become_author!(zine2)
    user.become_author!(zine3)
  end
end

