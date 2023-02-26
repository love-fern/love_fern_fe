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

      expect(page).to have_content('Erin')
      expect(page.find('img')[:src]).to eq("/assets/love-fern-1_720-96c5de8a50f1f07e41baf35f3757bb5f1f6ba47a627a79ffc310a60b7851664e.png")
      expect(page).to have_content('Text')
      expect(page).to have_button('Water Fern')
      expect(page).to have_button('Compost Fern')
    end
  end
end