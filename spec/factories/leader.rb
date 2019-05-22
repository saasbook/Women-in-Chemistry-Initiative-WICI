FactoryBot.define do
  factory :leader do
    firstname { "Benny" }
    lastname { "Lenny" }
    role { "Boss" }
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/goodfile.png')))}
  end

  factory :invalid_leader, parent: :leader do
    firstname { "" }
    lastname { "" }
    role { "Boss" }
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/goodfile.png')))}
  end

  factory :large_photo_leader, parent: :leader do
    firstname { "Menny" }
    lastname { "Lenny" }
    role { "Boss" }
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/largefile.png')))}
  end

  factory :bad_photo_leader, parent: :leader do
    firstname { "Quenny" }
    lastname { "Lenny" }
    role { "Boss" }
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/badfile.txt')))}
  end

end
