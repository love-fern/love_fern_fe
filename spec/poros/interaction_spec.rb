require 'rails_helper'

RSpec.describe Interaction do
  let(:interaction) {
    Interaction.new({
      :id=>"2",
      :type=>"interaction",
      :attributes=>{:evaluation=>0.5, :description=>"message", :created_at=>DateTime.now.new_offset(0).to_s}
    })}

  describe '#display_message' do
    context 'message' do
      it 'returns the interaction in a readable format' do
        expect(interaction.display_message).to eq('You exchanged positive words today.')
      end
    end

    context 'activity' do
      it 'returns the interaction in a readable format' do
        interaction.instance_variable_set(:@description, 'Learn Javascript')

        expect(interaction.display_message).to eq('You decided to learn Javascript today.')
      end
    end
  end

  describe '#days_ago' do
    it 'returns readable format of days since last interaction' do
      expect(interaction.send(:days_ago)).to eq('today')

      interaction.instance_variable_set(:@created_at, interaction.created_at - 1.days)
      
      expect(interaction.send(:days_ago)).to eq('yesterday')
      
      interaction.instance_variable_set(:@created_at, interaction.created_at - 1.days)

      expect(interaction.send(:days_ago)).to eq('2 days ago')
      
      interaction.instance_variable_set(:@created_at, interaction.created_at - 8.days)

      expect(interaction.send(:days_ago)).to eq('10 days ago')
    end
  
  end
end