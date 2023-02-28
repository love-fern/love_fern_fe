require 'rails_helper'

RSpec.describe 'Welcome Index', type: :feature do
  describe 'Welcome Page' do
    it 'shows the title and site information' do
      visit root_path

      expect(page).to have_content('Love Fern')
      expect(page).to have_content("At Love Fern, we believe that strong relationships are the foundation of a happy and fulfilling life. That's why we've created a tool that empowers you to build and maintain meaningful connections with the people you care about most. Try Love Fern today and see how it can transform your relationships!")
    end

    it 'has a button for Google OAuth' do
      visit root_path

      expect(page).to have_button('Continue with Google')
    end
  end

  describe 'Navbar' do
    let(:user) do
      {
        'uid' => '110920554030325122207',
        'name' => 'Samuel Cox',
        'email' => 'samc1253@gmail.com',
        'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
      }
    end

    it 'navbar always has home / about link options' do
      visit root_path

      expect(page).to have_link(href: root_path)
      expect(page).to have_link('About', href: about_path)
      expect(page).to_not have_link('Greenhouse')
      expect(page).to_not have_link('Log Out')
    end

    it 'navbar shows all links if user is logged in' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to have_link(href: root_path)
      expect(page).to have_link('About', href: about_path)
      expect(page).to have_link('Greenhouse', href: greenhouse_path)
      expect(page).to have_link('Log Out', href: session_path)
    end
  end
end
