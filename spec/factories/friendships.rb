FactoryBot.define do
  factory :friendship do
    trait :with_users do
      user_id { create(:user).id }
      friend_id { create(:user).id }
    end

    trait :accepted do
      accepted_at { Time.now }
    end
  end
end
