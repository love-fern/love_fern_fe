require 'rails_helper'

RSpec.describe 'About Index', type: :feature do
  describe 'About Page' do
    it 'shows all about information' do
      visit about_path

      expect(page).to have_content("Love Fern is an application that allows users to cultivate the relationships with important people in their lives by taking care of a fern. 'Water your fern' by copying and pasting a message or conversation with that person, and Love Fern will automatically analyze the message and update the fern graphic to reflect its current status.")
    end

    it 'has instructions' do
      visit about_path

      expect(page).to have_content("Instructions")
      expect(page).to have_content("Click 'Plant a Fern' button. Your fern is an important person in your life. You will be able to name your fern, choose a shelf group, and a preferned contact method.")
    end

    it 'has team information' do
      visit about_path

      expect(page).to have_content("Anthony Ongaro")
      expect(page).to have_content("Anthony Blackwell Tallent")
      expect(page).to have_content("Brady Rohrig")
      expect(page).to have_content("Drew Layton")
      expect(page).to have_content("J Seymour")
      expect(page).to have_content("Samuel Cox")
    end
  end
end