require 'rails_helper'

RSpec.describe 'fern fertilize' do
  describe 'calling activity api', :vcr do
    let(:user) do
      {
        'uid' => '110920554030325122207',
        'name' => 'Samuel Cox',
        'email' => 'samc1253@gmail.com',
        'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
      }
    end

    it 'has content' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit fertilize_fern_path(2)

      expect(page).to have_content('Fertilize Your Fern!')
      expect(page).to have_button('Sure!')
      expect(page).to have_button('Find Something Else')
      expect(page).to have_button('Maybe Not...')
    end

    it 'can fertilize a fern' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit fern_path(4)
      within('#fern-show-header') do
        expect(page.find('img')[:src]).to eq('/assets/love-fern-1_720-2bb2636c5a7f6e6f5ed558e65f6a2d633eece82068e9813c479f104005f45b45.png')
      end
      visit fertilize_fern_path(4)

      click_button('Sure!')

      expect(current_path).to eq(fern_path(4))

      within('#fern-show-header') do
        expect(page.find('img')[:src]).to eq("/assets/love-fern-3_720-e1a14184dd1f51072e8efabb4620f8fd86e43fef0e5205e2e54d5018df467890.png")
      end
    end
  end
end
