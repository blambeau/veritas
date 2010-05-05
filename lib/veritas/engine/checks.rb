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
            ::Veritas::Relation::Header.coerce(arg.to_a.sort{|a1, a2| a1[0].to_s <=> a2[0].to_s})
          else
            raise ArgumentError, "Invalid relation header #{arg}", caller if raise_on_error
            nil
        end
      end
      def valid_header?(arg) !!valid_header(arg, false) end
      
      
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
      
    end # module Checks
  end # module Engine
end # module Veritas