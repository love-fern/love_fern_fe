require 'rails_helper'

RSpec.describe 'Fern Show', type: :feature do
  let(:user) do
    {
      'uid' => '110920554030325122207',
      'name' => 'Samuel Cox',
      'email' => 'samc1253@gmail.com',
      'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
    }
  end

  let(:user_2) do
    {
      'uid' => '113234860329276513988',
      'name' => 'Anthony Ongaro',
      'email' => 'aongaro@gmail.com',
      'image' =>
       'https://lh3.googleusercontent.com/a/AGNmyxZaV6gpWLtMVqa4RCcgDsiigEijEnmEviTX2mhQ1Q=s96-c',
      'google_id' => '113234860329276513988'
    }
  end

  describe 'Fern Show Page', :vcr do
    it 'Shows the fern information' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit fern_path(2)

      within('#fern-show-header') do
        expect(page).to have_content('Brian')
        expect(page.find('img')[:src]).to eq('/assets/love-fern-1_720-2bb2636c5a7f6e6f5ed558e65f6a2d633eece82068e9813c479f104005f45b45.png')
      end
      expect(page).to have_content('Phone')
      expect(page).to have_button('Water Fern')
      expect(page).to have_button('Compost Fern')
      expect(page).to have_button('Fertilize Fern')
    end

    it 'displays the last 3 interactions' do
      # VCR.use_cassette("Fern_Show/Fern_Show_Page/displays_the_last_3_interactions.yml") do |cassette|
      #   puts cassette.send(:raw_cassette_bytes)
      # end

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit fern_path(2)
  
      binding.pry
  
      within '#last_3_interactions' do
        expect(page).to have_content('Last Three Interactions:')
      end
      
      click_button 'Water Fern'
      fill_in :interaction, with: 'I watered this fern today. I love pizza. I love you.'
      click_button 'Water Fern'
  
      within '#last_3_interactions' do
        images = page.all('img')
  
        expect(images[0][:src]).to eq("/assets/emojis/6-0a948fb5518898d7aecf8c8ce0a071241bd278244434ada1a9036ffa9c642c53.png")
        expect(page).to have_content("You exchanged positive words today.")
      end
  
      click_button 'Water Fern'
      fill_in :interaction, with: 'You Suck, I hate you'
      click_button 'Water Fern'
  
      within '#last_3_interactions' do
        images = page.all('img')
  
        expect(images[0][:src]).to eq("/assets/emojis/1-b0fd85cc734951271f10961a1ffd8275ab4246652c59e3550c91c19a6a4e4028.png")
        expect(page).to have_content("You exchanged negative words today.")
  
        expect(images[1][:src]).to eq("/assets/emojis/6-0a948fb5518898d7aecf8c8ce0a071241bd278244434ada1a9036ffa9c642c53.png")
        expect(page).to have_content("You exchanged positive words today.")
      end
  
      visit fertilize_fern_path(2)
      click_button 'Sure!'
      
      within '#last_3_interactions' do
        images = page.all('img')
  
        expect(images[0][:src]).to eq("/assets/emojis/activity-73fdd286e8c3022d2cac58706016da71ae5588146cfbeeda3a4afb549f0840cd.png")
        expect(page).to have_content("You decided to ") # test for activity dynamically
        expect(page).to have_content(" today.")
  
        expect(images[1][:src]).to eq("/assets/emojis/1-b0fd85cc734951271f10961a1ffd8275ab4246652c59e3550c91c19a6a4e4028.png")
        expect(page).to have_content("You exchanged negative words today.")
  
        expect(images[2][:src]).to eq("/assets/emojis/6-0a948fb5518898d7aecf8c8ce0a071241bd278244434ada1a9036ffa9c642c53.png")
        expect(page).to have_content("You exchanged positive words today.")
      end
    end

    it 'Will not navigate if the user is not logged in' do
      visit fern_path(1)

      expect(page).to have_content('You must be logged in to access this page')
    end

    it 'will not navigate if the user is not the correct user for the fern' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)
      visit fern_path(1)

      expect(page).to have_content('Focus on your own Ferns for now!')
    end
  end

  describe 'Fern Delete', :vcr do
    it 'Can Compost a fern' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_fern_path
      fill_in('name', with: 'Deletable')
      fill_in('preferred_contact_method', with: 'None')
      click_button('Plant!')
      
      within(:xpath, '//*[contains(@id,"Deletable")]') do
        click_link
      end
      click_button('Compost Fern')

      expect(current_path).to eq(greenhouse_path)
      expect(page).to have_content('Deletable has been composted! Boundaries are healthy, good for you!')
      within('#friends') do
        expect(page).to_not have_content('Deletable')
      end
    end

  end
end
