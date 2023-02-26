require 'rails_helper'

RSpec.describe 'Add Interaction To Fern', type: :feature do
  describe 'Edit Fern', :vcr do
    let(:user) { {
      'uid' => "110920554030325122207",
      'name' => "Samuel Cox",
      'email' => "samc1253@gmail.com",
      'image' => "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
    } }

    it 'has the name of the fern at the top of the page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit water_fern_path(1)

      expect(page).to have_content("Erin's Fern")
      expect(page).to have_content('Add Interaction')
      expect(page).to have_field('Interaction')

      within('#disclaimer-warning') do
        expect(page).to have_content('Disclaimer: Interaction analysis is done by a machine learning model.')
      end
    end

    it 'can add an interaction to a fern' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit water_fern_path(1)

      fill_in 'Interaction', with: 'I watered this fern today. I love pizza. I love you.'
      click_button 'Water Fern'

      expect(current_path).to eq(fern_path(1))
    end

    it 'sp: will not allow an empty interaction' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit water_fern_path(1)

      fill_in 'Interaction', with: ''
      click_button 'Water Fern'

      expect(page).to have_content("Interaction can't be blank")
      expect(current_path).to eq(water_fern_path(1))
    end

    it 'sp: will not allow a single space interaction' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit water_fern_path(1)

      fill_in 'Interaction', with: ' '
      click_button 'Water Fern'

      expect(page).to have_content("Interaction can't be blank")
      expect(current_path).to eq(water_fern_path(1))
    end
  end
end