require 'rails_helper'

RSpec.describe 'User Show', type: :feature do
  describe 'User Show Page' do
    let(:user) { {
      uid: "110920554030325122207",
      name: "Samuel Cox",
      email: "samc1253@gmail.com",
      image: "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
    } }
    it 'shows all ferns for a specific user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit greenhouse_path

      expect(page).to have_content("Samuel Cox's Greenhouse")
    end

    it 'will not navigate to the page if the user is not logged in' do
      visit greenhouse_path

      expect(page).to have_content("You must be logged in to access this page")
    end
  end
end