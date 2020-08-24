require_relative 'card/network'

module Card
  def self.start
    puts 'Enter the credit card number'
    credit_card_number = gets.chomp

    network = Card::Network.new
    network_name = network.detect_network(credit_card_number)

    if network
      puts "Network: #{network_name}"
    else
      puts 'Network not found'
    end
  end
end

Card.start
