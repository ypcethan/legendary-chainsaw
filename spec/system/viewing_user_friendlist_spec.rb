require 'rails_helper'

RSpec.describe "Viewing friend requests" do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  let(:user4) { create(:user) }

  before do
    user.skip_confirmation!
    user.save

    sign_in user
  end

  context "when the user visit other's profile page" do

    it 'shows a list of friends' do
      user.send_frend_request(user2)
      user3.send_frend_request(user2)
      user4.send_frend_request(user2)
      user2.accept_request(user3)
      user2.accept_request(user4)

      path = ERB::Util.url_encode(user2.username)
      visit "profiles/#{path}"
      expect(page).to have_content user3.username
      expect(page).to have_content user4.username
    end
  end
end
