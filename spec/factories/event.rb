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

  factory :large_photo_event, parent: :event do
    name "Event large photo"
    description "asdlkfjas;ldkfjasdf"
    date "29-Jul-3018"
    location "someplace"
    tickets "tickets.com"
    capacity 1000
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/largefile.png')))
  end

  factory :bad_photo_event, parent: :event do
    name "Event bad photo"
    description "asdlkfjas;ldkfjasdf"
    date "29-Jul-3018"
    location "someplace"
    tickets "tickets.com"
    capacity 1000
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/badfile.txt')))
  end

  factory :good_photo_event, parent: :event do
    name "Event good photo"
    description "asdlkfjas;ldkfjasdf"
    date "29-Jul-3018"
    location "someplace"
    tickets "tickets.com"
    capacity 1000
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/goodfile.png')))
  end
end