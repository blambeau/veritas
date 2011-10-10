# encoding: utf-8

module Veritas
  module Algebra

    # The difference between relations
    class Difference < Relation
      include Relation::Operation::Set

      # Iterate over each tuple in the set
      #
      # @example
      #   difference = Difference.new(left, right)
      #   difference.each { |tuple| ... }
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the set
      #
      # @return [self]
      #
      # @api public
      def each
        return to_enum unless block_given?
        right_set = right.to_set
        left.each { |tuple| yield tuple unless right_set.include?(tuple) }
        self
      end

      module Methods
        extend Aliasable

        inheritable_alias(:- => :difference)

        # Return the difference between relations
        #
        # @example
        #   difference = relation.difference(other)
        #
        # @param [Relation] other
        #
        # @return [Difference]
        #
        # @api public
        def difference(other)
          Difference.new(self, other)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Difference
  end # module Algebra
end # module Veritas
