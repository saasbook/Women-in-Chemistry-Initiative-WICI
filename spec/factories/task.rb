FactoryGirl.define do
  factory :task do
    name "Work"
    id 1
  end

  factory :create_task, parent: :task do
    name "Other"
    id 2
  end
end
