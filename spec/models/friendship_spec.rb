require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe '.accepted' do
    it 'returns list of accepted friendships' do
      f1 = create(:friendship, :with_users, :accepted)
      f2 = create(:friendship, :with_users, :accepted)
      f3 = create(:friendship, :with_users)

      results = Friendship.accepted.map(&:id)
      expect(results).to include(f1.id, f2.id)
      expect(results).to_not include(f3.id)
    end
  end

  describe '.unaccepted' do
    it 'returns list of unaccepted friendships' do
      f1 = create(:friendship, :with_users, :accepted)
      f2 = create(:friendship, :with_users, :accepted)
      f3 = create(:friendship, :with_users)

      results = Friendship.unaccepted.map(&:id)
      expect(results).to_not include(f1.id, f2.id)
      expect(results).to include(f3.id)
    end
  end

  describe '#accepted?' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    context 'when the accepted_at is nil' do
      it 'returns false' do
        friendship = Friendship.create(user_id: user1.id , friend_id: user2.id)

        expect(friendship.accepted?).to be_falsey
      end
    end

    context 'when the accepted_at is not nil' do
      it 'returns false' do
        friendship = Friendship.create(user_id: user1.id , friend_id: user2.id, accepted_at: Time.now)

        expect(friendship.accepted?).to be_truthy
      end
    end
  end
end
