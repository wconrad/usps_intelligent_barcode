# coding: utf-8

require 'usps_intelligent_barcode/codeword_map'
require 'usps_intelligent_barcode/crc'

# The namespace for everything in this library.
module Imb

  # This class turns a collection of fields into a string of symbols
  # for printing using a barcode font.
  class Barcode

    include Memoizer

    # @return [BarcodeId]
    attr_reader :barcode_id

    # @return [ServiceType]
    attr_reader :service_type

    # @return [MailerId]
    attr_reader :mailer_id

    # @return [SerialNumber]
    attr_reader :serial_number

    # @return [RoutingCode]
    attr_reader :routing_code

    # Create a new barcode
    #
    # @param barcode_id [String] Nominally a String, but can be
    #   anything that {BarcodeId.coerce} will accept.
    # @param service_type [String] Nominally a String, but can be
    #   anything that {ServiceType.coerce} will accept.
    # @param mailer_id [String] Nominally a String, but can be
    #   anything that {MailerId.coerce} will accept.
    # @param serial_number [String] Nominally a String, but can be
    #   anything that {SerialNumber.coerce} will accept.
    # @param routing_code [String] Nominally a String, but can be
    #   anything that {RoutingCode.coerce} will accept.
    def initialize(
          barcode_id,
          service_type,
          mailer_id,
          serial_number,
          routing_code
        )
      @barcode_id = BarcodeId.coerce(barcode_id)
      @service_type = ServiceType.coerce(service_type)
      @mailer_id = MailerId.coerce(mailer_id)
      @serial_number = SerialNumber.coerce(serial_number)
      @routing_code = RoutingCode.coerce(routing_code)
      validate_components
    end

    # Return a string to print using one of the USPS Intelligent Mail
    # Barcode fonts.  Each character of the string will be one of:
    # * 'T' for a tracking mark (neither ascender nor descender)
    # * 'A' for an ascender mark
    # * 'D' for a descender mark
    # * 'F' for a full mark (both ascender and descender)
    # @return [String] A string that represents the barcode.
    def barcode_letters
      symbols.map(&:letter).join
    end

    # @!group Algorithm Steps - Public for testing

    # The components ("fields" in the spec) are turned into a single
    # number that the spec calls "binary_data").  This is done through
    # a series of multiplications and additions.  See spec. section
    # 2.2.1 ("Step 1--Conversion of Data Fields into Binary Data").
    #
    # @return [Integer]
    def binary_data
      components.inject(0) do |data, component|
        component.shift_and_add_to(data, long_mailer_id?)
      end
    end
    memoize :binary_data

    # Compute the "frame check sequence."  See spec. section 2.2.2
    # ("Step 2--Generation of 11-Bit CRC on Binary Data").
    #
    # @return [Integer]
    def frame_check_sequence
      CRC.crc(binary_data)
    end
    memoize :frame_check_sequence

    # Compute the "code words."  This is an array of 10 integers
    # computed from the binary data.  See spec. section 2.2.3 ("Step
    # 3--Conversion from Binary Data to Codewords").
    #
    # @return [Array<Integer>] 10 "characters."
    def codewords
      codewords = []
      data = binary_data
      data, codewords[9] = data.divmod 636
      8.downto(0) do |i|
        data, codewords[i] = data.divmod 1365
      end
      codewords
    end
    memoize :codewords

    # Insert the orientation into the codewords.  The spec. doesn't
    # say much about this, other than to multiply codeword "J" by two.
    # This will cause the LSB to be zero, which is presumably the
    # orientation.  See spec. section 2.4.4 ("Step 4--Inserting
    # Additional Information into Codewords").
    #
    # @return [Array<Integer>] 10 "characters."
    def codewords_with_orientation_in_character_j
      result = codewords.dup
      result[9] *= 2
      result
    end

    # Insert the most significant bit of the FCS into codeword A.  See
    # spec. section 2.4.4 ("Step 4--Inserting Additional Information
    # into Codewords").
    #
    # @return [Array<Integer>] 10 "characters."
    def codewords_with_fcs_bit_in_character_a
      result = codewords_with_orientation_in_character_j.dup
      result[0] += 659 if frame_check_sequence[10] == 1
      result
    end      

    # Convert the codewords to "characters".  Each character is a
    # 13-bit integer; there are 10 of them, labeled "A" through "J" by
    # the spec.  See spec. section 2.2.5 ("Step 5--Conversion from
    # Codewords to Characters"), para. "A".
    #
    # @return [Array<Integer>] 10 "characters."
    def characters
      CODEWORD_MAP.characters(codewords_with_fcs_bit_in_character_a)
    end

    # Fold the least-significant 10 bits of the FCS into the
    # "characters".  See spec. section 2.2.5 ("Step 5--Conversion from
    # Codewords to Characters"), para. "B".
    #
    # @return [Array<Integer>] 10 "characters".
    def characters_with_fcs_bits_0_through_9
      characters.each_with_index.map do |character, i|
        if frame_check_sequence[i] == 1
          character ^ 0b1111111111111
        else
          character
        end
      end
    end

    # @!endgroup

    private

    # :stopdoc:
    BAR_MAP = BarMap.new
    CODEWORD_MAP = CodewordMap.new
    CRC = Crc.new
    # :startdoc:

    def validate_components
      components.each do |component|
        component.validate(long_mailer_id?)
      end
    end

    def components
      [
        @routing_code,
        @barcode_id,
        @service_type,
        @mailer_id,
        @serial_number,
      ]
    end

    def long_mailer_id?
      @mailer_id.long?
    end

    # Map the "characters" to symbols.  Here is where the barcode is made.
    #
    # @return [Array<BarSymbol>]
    def symbols
      BAR_MAP.symbols(characters_with_fcs_bits_0_through_9)
    end

  end

end
