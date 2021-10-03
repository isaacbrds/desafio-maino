FactoryBot.define do
  factory :post do 
    title {Faker::Name.name}
    thumbnail {Rack::Test::UploadedFile.new(Rails.root.join("spec/support/images/avatar.png"))}
    user 
  end
end
