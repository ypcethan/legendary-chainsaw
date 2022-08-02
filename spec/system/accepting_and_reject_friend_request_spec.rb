require 'rails_helper'

RSpec.describe "Accept and reject friend request" do

  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }

  before do
    user.skip_confirmation!
    user.save

    sign_in user
  end

  context 'accept friend request' do
    it '' do
      user2.send_frend_request(user)
      user3.send_frend_request(user)

      path = ERB::Util.url_encode(user.username)
      visit "profiles/#{path}"

      within "#request-user-#{user2.id}" do
        click_button 'Accept'
      end
      ids = user.friendships.map(&:friend_id)
      expect(ids).to include(user2.id)
      expect(ids).to_not include(user3.id)
    end
  end

  context 'reject friend request' do
    it '' do
      user2.send_frend_request(user)
      user3.send_frend_request(user)

      path = ERB::Util.url_encode(user.username)
      visit "profiles/#{path}"

      within "#request-user-#{user2.id}" do
        click_button 'Reject'
      end
      ids = user.friendships.map(&:friend_id)
      expect(ids).to_not include(user2.id)
      expect(ids).to_not include(user3.id)
    end
  end
end
