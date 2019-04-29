FactoryGirl.define do
  factory :admin do
    id 2
    email "john@smith.com"
    approved true
    password "123456"
    password_confirmation "123456"
  end

  factory :test_admin, parent: :admin do
    id 1
    email "jane@with.com"
    approved true
    password "123456"
    password_confirmation "123456"
  end

  factory :unapproved_admin, parent: :admin do
    id 3
    email "bane@cia.com"
    password "123456"
    password_confirmation "123456"
  end

end
