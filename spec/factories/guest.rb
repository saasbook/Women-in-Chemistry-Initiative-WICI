FactoryGirl.define do
  factory :guest do
    firstname "John"
    lastname "Smith"
    email "john@smith.com"
  end

  factory :invalid_guest, parent: :guest do
    firstname "John"
    lastname "Smith"
    email "notgood"
  end
end