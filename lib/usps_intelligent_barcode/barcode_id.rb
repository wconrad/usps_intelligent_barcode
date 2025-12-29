module Imb

  # This class represents a Barcode ID, one of the fields that is used
  # to generate a barcode.
  class BarcodeId

    # The allowable range of a barcode ID
    RANGE = 0..94

    # The allowable range of a barcode ID's least significant digit
    LSD_RANGE = 0..4

    # Turn the argument into a BarcodeID if possible.  Accepts any of:
    # * {BarcodeId}
    # * String
    # * Integer
    #
    # @return [BarcodeId]
    # @raise [ArgumentError] If the argument cannot be coerced

    def self.coerce(o)
      case o
      when BarcodeId
        o
      when String
        new(o.to_i)
      when Integer
        new(o)
      else
        raise ArgumentError, 'Cannot coerce to BarcodeId'
      end
    end

    # Create a new BarcodeId
    #
    # @param value [Integer] The barcode ID
    def initialize(value)
      @value = value
    end

    # Return true if this object is equal to o
    #
    # @param o [Object] Any object acceptable to {.coerce}
    def ==(o)
      BarcodeId.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    # @return [Integer] The integer value of the barcode ID
    def to_i
      @value
    end

    # @return [String] The string value of the barcode ID
    def to_s
      "%02d" % @value
    end

    # @!group Internal

    # Validate the value.
    #
    # @param long_mailer_id [boolean] truthy if the mailer ID is long
    #   (9 digits).
    # @raise ArgumentError if invalid
    def validate(long_mailer_id)
      unless RANGE === @value
        raise ArgumentError, "Must be #{RANGE}"
      end
      unless LSD_RANGE === least_significant_digit
        raise ArgumentError, "Least significant digit must be #{LSD_RANGE}"
      end
    end

    # Add this object's value to target, shifting it left as many
    # digts as are needed to make room.
    #
    # @param target [Integer] The target to be shifted and added to
    # @param long_mailer_id [boolean] truthy if the mailer ID is long
    #   (9 digits).
    # @return [Integer] The new value of the target
    def shift_and_add_to(target, long_mailer_id)
      target *= 10
      target += most_significant_digit
      target *= 5
      target += least_significant_digit
      target
    end

    # @!endgroup

    private

    def most_significant_digit
      @value / 10
    end

    def least_significant_digit
      @value % 10
    end

  end

end
