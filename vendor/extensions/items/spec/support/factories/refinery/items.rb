
FactoryGirl.define do
  factory :item, :class => Refinery::Items::Item do
    sequence(:model) { |n| "refinery#{n}" }
  end
end

