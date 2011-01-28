module Veritas
  module Engine
    module Checks

      # Checks if arg could form a valid header or raises an ArgumentError.
      def valid_header!(arg, raise_on_error = true)
        return case arg
          when ::Veritas::Relation::Header
            arg
          when Array
            ::Veritas::Relation::Header.coerce(arg)
          when Hash
            if arg.keys.all?{|k| k.is_a?(Symbol)} &&
               arg.values.all?{|v| v.is_a?(Class)}
              ::Veritas::Relation::Header.coerce(arg.to_a.sort{|a1, a2| a1[0].to_s <=> a2[0].to_s})
            else
              raise ArgumentError, "Invalid relation header #{arg}", caller if raise_on_error
            end
          else
            raise ArgumentError, "Invalid relation header #{arg}", caller if raise_on_error
        end
      end
      def valid_header?(arg) !!valid_header!(arg, false) end
      
      # Checks if _arg_ is a valid relation or raises an ArgumentError.
      def is_relation!(arg, raise_on_error = true)
        return arg if ::Veritas::Relation === arg
        raise ArgumentError, "Invalid relation argument #{arg}", caller if raise_on_error
        false
      end
      def is_relation?(arg) !!is_relation!(arg, false) end
      
      # Checks if _arg_ is a valid attribute name of raises an ArgumentError
      def is_attribute_name!(arg, raise_on_error = true)
        return arg if Symbol===arg
        raise ArgumentError, "Invalid attribute name #{arg}", caller if raise_on_error
        false
      end
      def is_attribute_name?(arg) !!is_attribute_name!(arg, false) end
      
      # Checks if _symbols_ is an array of Symbol instances, or raises an ArgumentError.
      def are_attribute_names!(arg, raise_on_error = true)
        return arg if Array===arg && arg.all?{|s| is_attribute_name?(s)}
        raise ArgumentError, "Invalid attribute names #{arg.inspect}", caller if raise_on_error
        false
      end
      
      # Checks that a tuple literal (a ruby Hash) conforms to a given heading
      def valid_tuple_literal!(heading, tuple, raise_on_error = true)
        if Hash===tuple and tuple.size == heading.to_ary.size
          ok = heading.all?{|a| tuple.key?(a.name) and a.valid_value?(tuple[a.name])}
          return tuple if ok
        end
        raise_on_error ? raise(ArgumentError, "Invalid tuple #{tuple} for #{heading}", caller) : false
      end
      def valid_tuple_literal?(heading, tuple) valid_tuple_literal!(heading, tuple, false); end
      
      # Checks that an array contains tuples conforming a heading only
      def valid_relation_literal!(heading, tuples, raise_on_error = true)
        if Array === tuples
          invalid = tuples.find{|t| !valid_tuple_literal?(heading, t)}
          if invalid
            raise_on_error ? raise(::Veritas::RelationMismatchError, "Invalid tuple #{invalid.inspect} for heading #{heading}", caller) : false
          else
            tuples
          end
        else
          raise_on_error ? raise(::Veritas::RelationMismatchError, "Invalid relation literal #{tuples.inspect}", caller) : false  
        end
      end
      
    end # module Checks
  end # module Engine
end # module Veritas