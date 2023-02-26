require 'rails_helper'

RSpec.describe 'Fern Show', type: :feature do
  describe 'Fern Show Page', :vcr do
    let(:user) { {
      'uid' => "110920554030325122207",
      'name' => "Samuel Cox",
      'email' => "samc1253@gmail.com",
      'image' => "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
    } }

    it 'Shows the fern information' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit fern_path(1)

      within('#fern-show-header') do
        expect(page).to have_content('Erin')
        expect(page.find('img')[:src]).to eq("/assets/love-fern-1_720-2bb2636c5a7f6e6f5ed558e65f6a2d633eece82068e9813c479f104005f45b45.png")
      end
      expect(page).to have_content('Text')
      expect(page).to have_button('Water Fern')
      expect(page).to have_button('Compost Fern')
    end

    it 'Will not navigate if the user is not logged in' do
      visit fern_path(1)

      expect(page).to have_content('You must be logged in to access this page')
    end
  end

  describe 'Fern Delete', :vcr do
    let(:user) { {
      'uid' => "110920554030325122207",
      'name' => "Samuel Cox",
      'email' => "samc1253@gmail.com",
      'image' => "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
    } }
    it 'Can Compost a fern' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_fern_path
      fill_in('name', with: 'Deletable')
      fill_in('preferred_contact_method', with: 'None')
      click_button('Plant!')
      visit fern_path(10)

      click_button('Compost Fern')
      expect(current_path).to eq(greenhouse_path)
      expect(page).to_not have_content('Deletable')
    end
  end
end