FactoryBot.define do
  factory :customer do
    name {Faker::Name.name}
    email {Faker::Internet.email}
  end
end
