FactoryGirl.define do
  factory :assignment do
    task_id 1
    volunteer_id 1
  end

  factory :create_assignment, parent: :assignment do
    task_id 2
    volunteer_id 2
  end
end
