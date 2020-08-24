require_relative 'card/network'

module Card
  def self.start
    puts "Enter the credit card number"
    credit_card_number = gets.chomp

    card = Card::Network.new
    network = card.detect_network(credit_card_number)

    if network
      puts "Network: #{network}"
    else
      puts "Network not found"
    end
  end
end

Card.start
