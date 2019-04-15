FactoryGirl.define do
  factory :task do
    title "Work"
    id 1
  end

  factory :create_task, parent: :task do
    title "Other"
    id 2
  end
end
