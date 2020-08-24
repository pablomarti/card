require 'card/network'

RSpec.describe Card::Network do
  subject { Card::Network.new }

  describe '#detect_network' do
    TEST_CASES = [
      ['341234567890123', 'American Express'],
      ['371234567890123', 'American Express'],
      ['38123456789012', 'Diners Club'],
      ['5112345678901245', 'MasterCard'],
      ['5212345678901245', 'MasterCard'],
      ['5312345678901245', 'MasterCard'],
      ['5412345678901245', 'MasterCard'],
      ['5512345678901245', 'MasterCard'],
      ['4512345678901', 'Visa'],
      ['4512345678901345', 'Visa'],
      ['4512345678901345345', 'Visa'],
    ]
    
    it 'correctly identifies card networks' do
      TEST_CASES.each do | (card_number, expected_network) |
        expect(subject.detect_network(card_number)).to eq expected_network
      end
    end
  end  
end
