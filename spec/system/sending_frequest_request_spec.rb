require 'rails_helper'

RSpec.describe "Sending friend request" do

  let(:user) { create(:user) }

  before do
    user.skip_confirmation!
    user.save

    sign_in user
  end

  context 'when user sign in and visits the profile index page' do
    it 'can see friend request button for each user' do
      user_two = create(:user)
      visit profiles_path
      within "#user-#{user_two.id}" do
        click_button 'Connect'
      end

      expect(user.friendships.unaccepted.map(&:user_id)).to include user.id
      expect(user.friendships.unaccepted.map(&:friend_id)).to include user_two.id
    end
  end
end
