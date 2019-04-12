FactoryGirl.define do
  factory :event do
    name "Event"
    description "asdlkfjas;ldkfjasdf"
    date "25-Nov-2018"
    location "someplace"
    tickets "tickets.com"
    capacity 10
  end

  factory :future_event, parent: :event do
    name "Event"
    description "asdlkfjas;ldkfjasdf"
    date "25-Nov-3018"
    location "someplace"
    tickets "tickets.com"
    capacity 200
  end

  factory :invalid_event, parent: :event do
    name ""
    description ""
    date ""
    location ""
    tickets ""
    capacity ""
  end

  factory :full_event, parent: :event do
    name "Event"
    description "asdlkfjas;ldkfjasdf"
    date "25-Nov-3018"
    location "someplace"
    tickets "tickets.com"
    capacity 0
  end
end