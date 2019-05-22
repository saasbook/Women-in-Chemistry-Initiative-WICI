FactoryBot.define do
  factory :guest do
    first_name { "John" }
    last_name { "Smith" }
    email { "john@smith.com" }
    occupation { "Other" }
    gender { "Other" }
    department { "Other" }
  end

  factory :invalid_guest, parent: :guest do
    first_name { "John" }
    last_name { "Smith" }
    email { "notgood" }
    occupation { "Other" }
    gender { "Other" }
    department { "Other" }
  end
end