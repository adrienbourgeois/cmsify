FactoryGirl.define do
  factory :text, class: Cmsify::Text do
    content Faker::Lorem.sentence
    sequence(:slug) { |n| "slug#{n}" }
  end
end
