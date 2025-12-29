module Imb

  # This class represents a mailer ID.
  class MailerId

    # The allowable range for a short (6-digit) mailer ID
    SHORT_RANGE = 0..899_999

    # The allowable range for a long (9-digit) mailer ID
    LONG_RANGE = 900_000_000..999_999_999

    # The list of all allowable ranges for a mailer ID
    RANGES = [SHORT_RANGE, LONG_RANGE]

    # Turn the argument into a MailerID if possible.  Accepts:
    # * {MailerId}
    # * String
    # * Integer
    # @return [MailerId]
    # @raise [ArgumentError] If the argument cannot be coerced
    def self.coerce(o)
      case o
      when MailerId
        o
      when String
        new(o.to_i)
      when Integer
        new(o)
      else
        raise ArgumentError, 'Cannot coerce to MailerId'
      end
    end

    # Construct an instance.
    #
    # @param value [Integer]
    def initialize(value)
      @value = value
    end

    # Return true if this object is equal to o
    #
    # @param o [Object] Any object acceptable to {.coerce}
    def ==(o)
      MailerId.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    # @return [Integer] The integer value of the mailer ID
    def to_i
      @value
    end

    # @return [String] The string value of the mailer ID
    def to_s
      @value.to_s
    end

    # @!group Internal

    # Return true if this is a long (9 digit) mailer ID
    def long?
      LONG_RANGE === @value
    end

    # Validate the value.
    #
    # @param long_mailer_id [boolean] truthy if the mailer ID is long
    #   (9 digits).
    # @raise ArgumentError if invalid
    def validate(long_mailer_id)
      unless in_range?
        raise ArgumentError, "Must be #{RANGES.join(' or ')}"
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
      target * 10 ** num_digits + to_i
    end

    # @!endgroup

    private

    def in_range?
      RANGES.any? do |range|
        range === @value
      end
    end

    def num_digits
      if long?
        9
      else
        6
      end
    end

  end

end
