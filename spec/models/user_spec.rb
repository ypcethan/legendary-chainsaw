require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#friends' do

    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    it 'returns list for friends' do
    user1.friendships.create(friend_id: user2.id, accepted_at: Time.now)
    user1.friendships.create(friend_id: user3.id)

      expect(user1.friends.map(&:id)).to include(user2.id)
      expect(user1.friends.map(&:id)).to_not include(user3.id)
    end
  end
end
