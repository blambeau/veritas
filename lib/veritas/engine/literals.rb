module Veritas
  module Engine
    module Literals
      
      # Creates a relation value with a header and array of tuples
      #
      # Example:
      #
      #   suppliers = Veritas::relation(:id => String, :name => String) {[
      #     {:id => 'S1', :name => 'Jones'},
      #     {:id => 'S2', :name => 'Smith'},
      #   ]}
      #
      def relation(header_hash = {}, tuples = nil)
        header = valid_header!(header_hash)
        tuples = valid_relation_literal!(header, tuples || (block_given? ? (yield || []) : []) || [])
        attributes = header.collect{|a| a.name}
        tuples = tuples.collect{|t| t.values_at(*attributes)}.uniq
        ::Veritas::Relation.new(header, tuples)
      end
      alias :Relation :relation
    
    end # module Literals
  end # module Engine
end # module Veritas