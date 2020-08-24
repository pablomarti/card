module Card
  class Network
    NETWORKS = {
      visa: 'Visa',
      mastercard: 'MasterCard',
      american_express: 'American Express',
      diners_club: 'Diners Club'
    }.freeze

    def detect_network(card_number)
      return nil unless card_number =~ /^[0-9]*$/

      network = detect_diners_club(card_number) if card_number.length == 14
      network ||= detect_american_express(card_number) if card_number.length == 15
      network ||= detect_visa(card_number) if card_number.length == 13 ||card_number.length == 19
      network ||= detect_mastercard_or_visa(card_number) if card_number.length == 16

      network ? NETWORKS[network] : nil
    end

    private

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
