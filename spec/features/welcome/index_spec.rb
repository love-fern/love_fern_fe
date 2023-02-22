require 'rails_helper'

RSpec.describe 'Welcome Index', type: :feature do
  describe 'Welcome Page' do
    it 'shows the title and site information' do
      visit root_path

      expect(page).to have_content('Love Fern')
      expect(page).to have_content("At LoveFern, we believe that strong relationships are the foundation of a happy and fulfilling life. That's why we've created a tool that empowers you to build and maintain meaningful connections with the people you care about most. Try LoveFern today and see how it can transform your relationships!")
    end
  end
end