require 'rails_helper'

RSpec.describe Fern, :vcr do
  let(:fern) { FernFacade.get_fern_stats('110920554030325122207', 9) }

  describe '#health_history' do
    it 'returns a hash of fern health history for graph' do
      hash = fern.health_history

      expect(hash).to be_a(Hash)

      hash.each do |key, value|
        expect(key).to be_an(Integer) 
        expect(value).to be_a(Float)
      end
    end
  end

  describe '#interaction_history' do
    it 'returns a hash of interaction history for graph' do
      hash = fern.interaction_history

      expect(hash).to be_a(Hash)

      hash.each do |key, value|
        expect(key).to be_an(Integer) 
        expect(value).to be_a(Float)
      end
    end
  end
end