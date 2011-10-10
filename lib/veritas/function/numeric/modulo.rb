# encoding: utf-8

module Veritas
  class Function
    class Numeric

      # A class representing a modulo function
      class Modulo < Numeric
        include Binary, Comparable

        # Return the Modulo operation
        #
        # @example
        #   Modulo.operation  # => :%
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :%
        end

        module Methods
          extend Aliasable

          inheritable_alias(
            :%   => :modulo,
            :mod => :modulo
          )

          # Return a modulo function
          #
          # @example
          #   modulo = attribute.modulo(other)
          #
          # @param [Object] other
          #
          # @return [Modulo]
          #
          # @api public
          def modulo(other)
            Modulo.new(self, other)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }
        Numeric.class_eval            { include Methods }

      end # class Modulo
    end # class Numeric
  end # class Function
end # module Veritas
