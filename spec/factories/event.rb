FactoryBot.define do
  factory :event do
    name { "a future event" }
    description { "asdlkfjas;ldkfjasdf" }
    date { "25-Nov-3018" }
    location { "someplace" }
    capacity { 10 }
  end

  factory :past_event, parent: :event do
    name { "a past event" }
    description { "asdlkfjas;ldkfjasdf" }
    date { "25-Nov-2018" }
    location { "someplace" }
    capacity { 200 }
  end

  factory :invalid_event, parent: :event do
    name { "" }
    description { "" }
    date { "" }
    location { "" }
    capacity { "" }
  end

  factory :full_event, parent: :event do
    name { "Event" }
    description { "asdlkfjas;ldkfjasdf" }
    date { "25-Nov-3018" }
    location { "someplace" }
    capacity { 0 }
  end
end