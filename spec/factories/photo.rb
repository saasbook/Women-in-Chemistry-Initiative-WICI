FactoryBot.define do
  factory :photo do
    description { "Having a good time at spats" }
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/goodfile.png')))}
  end

  factory :large_photo, parent: :photo do
    description { "Having a good time at spats" }
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/largefile.png')))}
  end

  factory :bad_photo, parent: :photo do
    description { "Having a good time at spats" } 
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/myfiles/badfile.txt')))}
  end
end
