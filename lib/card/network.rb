module Card
  class Network
    NETWORKS = {
      visa: 'Visa',
      mastercard: 'MasterCard',
      american_express: 'American Express',
      diners_club: 'Diners Club'
    }.freeze

    def detect_network(card_number)
      return nil unless valid_card?(card_number)

      network = case card_number.length
                when 14
                  detect_diners_club(card_number)
                when 15
                  detect_american_express(card_number)
                when 16
                  detect_mastercard_or_visa(card_number)
                when 13, 19
                  detect_visa(card_number)
      end

      network ? NETWORKS[network] : nil
    end

    private

    def valid_card?(card_number)
      card_number =~ /^[0-9]*$/
    end

    def detect_diners_club(card_number)
      codes = %w[38 39]
      prefix = card_number[0..1]
      codes.include?(prefix) ? :diners_club : nil
    end

    def detect_american_express(card_number)
      codes = %w[34 37]
      prefix = card_number[0..1]
      codes.include?(prefix) ? :american_express : nil
    end

    def detect_visa(card_number)
      prefix = card_number[0]
      prefix == '4' ? :visa : nil
    end

    def detect_mastercard(card_number)
      codes = %w[51 52 53 54 55]
      prefix = card_number[0..1]
      codes.include?(prefix) ? :mastercard : nil
    end

    def detect_mastercard_or_visa(card_number)
      detect_visa(card_number) || detect_mastercard(card_number)
    end
  end
end
