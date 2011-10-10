# encoding: utf-8

module Veritas
  class Relation
    module Operation

      # A mixin for Set relations
      module Set
        include Binary

        # Hook called when module is included
        #
        # @param [Module] descendant
        #   the module or class including Set
        #
        # @return [self]
        #
        # @api private
        def self.included(descendant)
          super
          descendant.extend ClassMethods
          self
        end

        # Initialize a Set
        #
        # @param [Relation] left
        # @param [Relation] right
        #
        # @return [undefined]
        #
        # @api private
        def initialize(left, right)
          super
          @header = left.header
        end

        module ClassMethods

          # Instantiate a new Set relation
          #
          # @example
          #   set = SetRelation.new(left, right)
          #
          # @param [Relation] left
          # @param [Relation] right
          #
          # @return [Set]
          #
          # @api public
          def new(left, right)
            assert_equivalent_headers(left, right)
            super
          end

        private

          # Assert that left and right have equivalent headers
          #
          # @param [Relation] left
          # @param [Relation] right
          #
          # @return [undefined]
          #
          # @raise [InvalidHeaderError]
          #   raised if the headers are not equivalent
          #
          # @api private
          def assert_equivalent_headers(left, right)
            if left.header != right.header
              raise InvalidHeaderError, 'the headers must be equivalent'
            end
          end

        end # module ClassMethods
      end # module Set
    end # module Operation
  end # class Relation
end # module Veritas
