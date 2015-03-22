FactoryGirl.define do

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :zine do
    sequence(:title) { |n| "Zine #{n}" }
    published true

    factory :unpublished_zine do
      published false
    end
  end

  factory :paragraph do
    sequence(:header) { |n| "Paragraph #{n}" }
    sequence(:content) { |n| "This is the number #{n} paragraph" }
    zine
  end

end