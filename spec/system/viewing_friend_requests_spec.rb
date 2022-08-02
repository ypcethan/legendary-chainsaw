require 'rails_helper'

RSpec.describe "Viewing friend requests" do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }

  before do
    user.skip_confirmation!
    user.save

    sign_in user
  end

  context 'when the user visit his own profile page' do

    it 'shows a list of friend requests' do
      user2.send_frend_request(user)
      user3.send_frend_request(user)

      path = ERB::Util.url_encode(user.username)
      visit "profiles/#{path}"
      expect(page).to have_content user2.username
      expect(page).to have_content user3.username
    end
  end
end
