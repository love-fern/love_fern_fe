require 'rails_helper'

RSpec.describe 'User Show', type: :feature do
  describe 'User Show Page', :vcr do
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
        'uid' => '158928345209680286502',
        'name' => 'Drew Layton',
        'email' => 'dlayton66@gmail.com',
        'image' => 'www.image.com'
      }
    end

    it 'shows all ferns for a specific user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit greenhouse_path

      expect(page).to have_content("Samuel Cox's Greenhouse")
    end

    it 'has a button to plant a fern' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit greenhouse_path

      click_button('Plant a Fern')
      expect(current_path).to eq(new_fern_path)
    end

    it 'will not navigate to the page if the user is not logged in' do
      visit greenhouse_path

      expect(page).to have_content('You must be logged in to access this page')
    end

    it 'shows each shelf for the user with their ferns' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit greenhouse_path

      expect(page).to have_content('Business Shelf')
      expect(page).to have_content('Friends Shelf')
      expect(page).to have_content('Family Shelf')
      within('#business') do
        expect(page).to have_content('Anthony')
        expect(page).to have_content('Drew')
        expect(page).to have_content('Brady')
      end
      within('#family') do
        expect(page).to have_content('Erin')
        expect(page).to have_content('Brian')
      end
      within('#friends') do
        expect(page).to have_content('Austin')
        expect(page).to have_content('Kieffer')
        expect(page).to have_content('Roshan')
        expect(page).to have_content('Nate')
      end
    end
    describe 'a link to fern show', :vcr do
      it 'links to a fern show page' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit greenhouse_path

        expect(page).to have_link(href: '/ferns/1')
        click_link(href: '/ferns/1')
        expect(current_path).to eq(fern_path(1))
      end
    end

    describe 'instructions partial' do
      it 'shows if all shelves are empty', :vcr do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)
  
        visit greenhouse_path
  
        expect(page).to have_content('Instructions')
        expect(page).to have_content('1. Plant A Fern')
      end
    end
  end

  describe 'Logout', :vcr do
    let(:user) do
      {
        'uid' => '110920554030325122207',
        'name' => 'Samuel Cox',
        'email' => 'samc1253@gmail.com',
        'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
      }
    end
  end
end
