FactoryGirl.define do
  factory :item do
    name { Faker::Lorem.word }
    done false
    bucketlist
  end
end
