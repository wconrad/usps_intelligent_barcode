module Imb

  # This class represents the mail piece's serial number.

  class SerialNumber

    # Turn the argument into a SerialNumber if possible.  Accepts:
    # * {SerialNumber}
    # * String
    # * Integer
    # @return [SerialNumber]
    def self.coerce(o)
      case o
      when SerialNumber
        o
      when String
        new(o.to_i)
      when Integer
        new(o)
      else
        raise ArgumentError, 'Cannot coerce to SerialNumber'
      end
    end

    # Construct an instance.
    #
    # @param [Integer] value
    def initialize(value)
      @value = value
    end

    # Return true if this object is equal to o
    # @param o [Object] Any object acceptable to {.coerce}
    def ==(o)
      SerialNumber.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    # @return [Integer] The integer value of the serial number
    def to_i
      @value
    end

    # @return [String] The string value of the serial number
    def to_s
      @value.to_s
    end

    # @!group Internal

    # Validate the value.
    #
    # @param long_mailer_id [boolean] truthy if the mailer ID is long
    #   (9 digits).
    # @raise ArgumentError if invalid
    def validate(long_mailer_id)
      range = 0..max_value(long_mailer_id)
      unless range === @value
        raise ArgumentError, "Must be #{range}"
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
      target * 10 ** num_digits(long_mailer_id) + to_i
    end

    # @!endgroup

    private

    def max_value(long_mailer_id)
      max_value = 10 ** num_digits(long_mailer_id) - 1
    end

    def num_digits(long_mailer_id)
      if long_mailer_id
        6
      else
        9
      end
    end

  end

end
