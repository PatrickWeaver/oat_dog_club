FactoryGirl.define do
  factory :user do
    name     "Patrick Weaver"
    email    "patrick@example.com"
    password "password"
    password_confirmation "password"
  end
end