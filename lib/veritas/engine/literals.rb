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
      def relation(*args)
        args = [{}] if args.empty?
        if valid_header?(args.first)
          header = valid_header!(header_hash = args.shift)
          tuples = args.empty? ? nil : args
          tuples = tuples.nil? ? (block_given? ? (yield || []) : []) : tuples
          tuples = valid_relation_literal!(header, tuples || [])
          attributes = header.collect{|a| a.name}
          tuples = tuples.collect{|t| t.values_at(*attributes)}.uniq
          ::Veritas::Relation.new(header, tuples)
        elsif (args.size == 1) && args.first.is_a?(Hash)
          header = Hash[args.first.collect{|pair|
            [pair[0], pair[1].class]
          }]
          relation(header, *args)
        else
          valid_header!(args.first)
        end
      end
      alias :Relation :relation
      
      # Create a tuple literal
      def tuple(hash)
        hash
      end
      
      def heading(hash)
        valid_header!(hash)
      end
    
    end # module Literals
  end # module Engine
end # module Veritas