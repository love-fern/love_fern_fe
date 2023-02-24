require 'rails_helper'

RSpec.describe 'User Show', type: :feature do
  describe 'User Show Page', :vcr do
    let(:user) { {
      'uid' => "110920554030325122207",
      'name' => "Samuel Cox",
      'email' => "samc1253@gmail.com",
      'image' => "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
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

    it 'shows each shelf for the user with their ferns' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit greenhouse_path

      expect(page).to have_content('Business Shelf')
      expect(page).to have_content('Friend Shelf')
      expect(page).to have_content('Family Shelf')
      within('#business') do
        expect(page).to have_content('Anthony')
        expect(page).to have_content('Drew')
        expect(page).to have_content('Brady')
      end
      within('#family') do
        expect(page).to have_content('Erin')
        expect(page).to have_content('Austin')
        expect(page).to have_content('Brian')
      end
      within('#friend') do
        expect(page).to have_content('Kieffer')
        expect(page).to have_content('Roshan')
        expect(page).to have_content('Nate')
      end
    end
  end
end