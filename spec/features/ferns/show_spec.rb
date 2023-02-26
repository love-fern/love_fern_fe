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
      visit fern_path(6)

      within("#fern-show-header") do
        expect(page).to have_content('Nate')
        expect(page.find('img')[:src]).to eq("/assets/love-fern-3_720-0cd1f1f74b0237a6b22e64df4b3293a0f752c1de8093f42a227351ed792184d5.png")
      end
      
      expect(page).to have_content('Email')
      expect(page).to have_button('Water Fern')
      expect(page).to have_button('Compost Fern')
    end
  end
end