namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end


def make_users
  User.create!(name: "Patrick",
               email: "pawea2@gmail.com",
               password: "password",
               password_confirmation: "password",
               admin: true)

end
