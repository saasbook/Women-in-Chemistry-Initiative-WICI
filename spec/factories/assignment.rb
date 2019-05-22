FactoryBot.define do
  factory :assignment do
    task_id { 1 }
    volunteer_id { 1 }
  end

  factory :duplicate_assign, parent: :assignment do
    task_id { 1 }
    volunteer_id { 2 }
  end
end
