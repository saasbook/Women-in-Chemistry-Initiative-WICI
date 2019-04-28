FactoryBot.define do
  factory :admin do
    id { 1 }
    email { "jane@with.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end
