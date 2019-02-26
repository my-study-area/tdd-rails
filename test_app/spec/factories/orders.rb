FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedio número - #{n}"}
    customer #form one
    # association :customer, factory: :customer #form two
  end
end
