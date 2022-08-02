require 'rails_helper'

RSpec.describe "User login" do
  let(:user) {
    create(:user, email: 'test1@gmail.com')
  }

  before do
    user.skip_confirmation!
    user.save
  end

  context 'with correct credentials' do
    it 'sign in user successfully' do
      visit new_user_session_path
      fill_in "Email", with: 'test1@gmail.com'
      fill_in "Password", with: 'password'
      click_button "Log in"

      expect(page).to have_content('Signed in successfully.')
    end
  end
end
