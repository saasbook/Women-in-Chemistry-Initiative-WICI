FactoryBot.define do
  factory :guest do
    firstname { "John" }
    lastname { "Smith" }
    email { "john@smith.com" }
    occupation { "Other" }
    gender { "Other" }
    department { "Other" }
  end

  factory :invalid_guest, parent: :guest do
    firstname { "John" }
    lastname { "Smith" }
    email { "notgood" }
    occupation { "Other" }
    gender { "Other" }
    department { "Other" }
  end
end