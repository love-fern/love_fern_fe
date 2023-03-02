require 'rails_helper'

RSpec.describe 'activity index aka FERN FERTILIZE' do
  describe 'calling activity api', :vcr do
    let(:user) do
      {
        'uid' => '110920554030325122207',
        'name' => 'Samuel Cox',
        'email' => 'samc1253@gmail.com',
        'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
      }
    end
    it 'link to fertilize path from fern path appears at low health' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # fern is at full health
      visit fern_path(6)

      expect(page).to_not have_button('Fertilize Fern')

      # fern health is set to 2
      visit fern_path(2)

      expect(page).to have_button('Fertilize Fern')

      click_button('Fertilize Fern')

      expect(current_path).to eq(fertilize_fern_path(2))
    end

    it 'fertilize / activity index has content' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit fertilize_fern_path(2)

      expect(page).to have_content('Fertilize Your Fern!')
    end

    it 'can fertilize a fern' do
      WebMock.disable!
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit fern_path(1)
      within('#fern-show-header') do
        expect(page.find('img')[:src]).to eq('/assets/love-fern-1_720-2bb2636c5a7f6e6f5ed558e65f6a2d633eece82068e9813c479f104005f45b45.png')
      end
      visit fertilize_fern_path(1)

      click_button('Sure!')

      expect(current_path).to eq(fern_path(1))

      within('#fern-show-header') do
        expect(page.find('img')[:src]).to eq('/assets/love-fern-4_720-96c5de8a50f1f07e41baf35f3757bb5f1f6ba47a627a79ffc310a60b7851664e.png')
      end
    end
  end
end
