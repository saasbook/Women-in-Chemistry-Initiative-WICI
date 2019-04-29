FactoryBot.define do
  factory :volunteer do
    id { 1 }
    firstname { "Jane" }
    lastname { "Doe" }
    email { "jane@with.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end

  factory :other_volunteer, parent: :volunteer do
    id { 2 }
    firstname { "John" }
    lastname { "Doe" }
    email { "john@with.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end

