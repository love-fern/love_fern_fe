require 'rails_helper'

RSpec.describe FernFacade, :vcr do
  describe '.get_fern_stats' do
    it 'creates a fern poro' do
      fern = FernFacade.get_fern_stats('110920554030325122207', 9)

      expect(fern.class).to eq(Fern)
    end
  end
end