FactoryGirl.define do
  factory :volunteer do
    firstname "John"
    lastname "Doe"
    email "john@smith.com"
    password "123456"
    password_confirmation "123456"
  end

  factory :test_volunteer, parent: :volunteer do
    firstname "Jane"
    lastname "Doe"
    email "jane@with.com"
    password "123456"
    password_confirmation "123456"
  end
end
