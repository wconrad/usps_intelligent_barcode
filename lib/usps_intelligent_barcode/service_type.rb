module Imb

  # This class represents a service type.
  class ServiceType

    # The valid range of a service type
    RANGE = 0..999

    # Turn the argument into a ServiceType if possible.  Accepts:
    # * {ServiceType}
    # * String
    # * Integer
    def self.coerce(o)
      case o
      when ServiceType
        o
      when String
        new(o.to_i)
      when Integer
        new(o)
      else
        raise ArgumentError, 'Cannot coerce to ServiceType'
      end
    end

    # @param value [Integer]
    def initialize(value)
      @value = value
    end

    # Return true if this object is equal to o
    # @param o [Object] Any object acceptable to {.coerce}
    def ==(o)
      ServiceType.coerce(o).to_i == to_i
    rescue ArgumentError
      false
    end

    # @return [Integer] The integer value of the service type
    def to_i
      @value
    end

    # @return [Integer] The string value of the service type
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
      unless (RANGE) === @value
        raise ArgumentError, "Must be #{RANGE}"
      end
    end

    # Add this object's value to target, shifting it left as many
    # digts as are needed to make room.
    #
    # @param [Integer] target The target to be shifted and added to
    # @param long_mailer_id [boolean] truthy if the mailer ID is long
    #   (9 digits).
    # @return [Integer] The new value of the target
    def shift_and_add_to(target, long_mailer_id)
      target * 10 ** NUM_DIGITS + to_i
    end

    # @!endgroup

    private

    NUM_DIGITS = 3 #:nodoc:

  end

end
