require 'rails_helper'

RSpec.describe 'Fern Edit', type: :feature do
  describe 'Add Interaction To Fern', :vcr do
    let(:user) do
      {
        'uid' => '110920554030325122207',
        'name' => 'Samuel Cox',
        'email' => 'samc1253@gmail.com',
        'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
      }
    end

    it 'has the name of the fern at the top of the page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit water_fern_path(1)

      expect(page).to have_content("Erin's Fern")
      expect(page).to have_content('Add Interaction')
      expect(page).to have_field(:interaction)

      within('#disclaimer-warning') do
        expect(page).to have_content('Interaction analysis is done by an advanced machine learning model.')
      end
    end

    it 'can add an interaction to a fern' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit water_fern_path(1)

      fill_in :interaction, with: 'I watered this fern today. I love pizza. I love you.'
      click_button 'Water Fern'

      expect(current_path).to eq(fern_path(1))
      expect(page).to have_content("You exchanged positive words")
    end

    it 'has dynamic flash messages' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit water_fern_path(1)
      fill_in :interaction, with: 'I love you.' # evaluation = 0.9
      click_button 'Water Fern'

      expect(page).to have_content("Wow! Your fern is speechless! That's just about the nicest thing anyone's ever said to it.")

      visit water_fern_path(1)
      fill_in :interaction, with: 'I watered this fern today. I love pizza. I love you.' # evaluation = 0.6
      click_button 'Water Fern'

      expect(page).to have_content("Your fern is beaming! That was awfully kind of you to say.")

      visit water_fern_path(1)
      fill_in :interaction, with: 'Let them eat muffins please friend' # evaluation = 0.3
      click_button 'Water Fern'

      expect(page).to have_content("Your fern liked that. It's feeling a bit better now.")

      visit water_fern_path(1)
      fill_in :interaction, with: 'We need to talk.' # evaluation = -0.1
      click_button 'Water Fern'

      expect(page).to have_content("Hmm... Your fern doesn't know what to think about that.")

      visit water_fern_path(1)
      fill_in :interaction, with: 'You are a strong muffin man.' # evaluation = -0.3
      click_button 'Water Fern'

      expect(page).to have_content("Oof. Your fern didn't much care for that.")

      visit water_fern_path(1)
      fill_in :interaction, with: "Please don't do that so quickly" # evaluation = -0.6
      click_button 'Water Fern'

      expect(page).to have_content("Yikes! Your fern just died a little inside.")

      visit water_fern_path(1)
      fill_in :interaction, with: 'I hate you' # evaluation = -0.9
      click_button 'Water Fern'

      expect(page).to have_content("The cruelty of man knows no bounds. Your fern is deeply hurt by these words.")


    end

    describe 'sad path' do
      it 'will not allow an empty interaction' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit water_fern_path(1)
  
        fill_in :interaction, with: ''
        click_button 'Water Fern'
  
        expect(page).to have_content("Interaction can't be blank")
        expect(current_path).to eq(water_fern_path(1))
      end

      it 'will not allow a single space interaction' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit water_fern_path(1)
  
        fill_in :interaction, with: ' '
        click_button 'Water Fern'
  
        expect(page).to have_content("Interaction can't be blank")
        expect(current_path).to eq(water_fern_path(1))
      end
    end
  end
end
