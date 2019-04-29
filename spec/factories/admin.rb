FactoryBot.define do
  factory :admin do
    id { 1 }
    email { "jane@with.com" }
    password { "123456" }
    approved { true }
    password_confirmation { "123456" }
  end

  factory :unapproved_admin, parent: :admin do
    id { 2 }
    email { "bane@cia.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end

  factory :other_admin, parent: :admin do
    id { 3 }
    email { "bobby@soffle.com" }
    password { "123456" }
    approved { true }
    password_confirmation { "123456" }
  end

end
