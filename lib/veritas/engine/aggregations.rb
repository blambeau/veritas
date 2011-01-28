module Veritas
  module Engine
    module Aggregations
      
      def min(attribute)
        lambda{|memo,t| 
          val = t[attribute]
          if memo.nil? 
            val
          elsif memo <= val
            memo
          else
            val
          end
        }
      end
      
      def max(attribute)
        lambda{|memo,t| 
          val = t[attribute]
          if memo.nil? 
            val
          elsif memo >= val
            memo
          else
            val
          end
        }
      end
      
      def count(*args)
        lambda{|memo,t| memo.nil? ? 1 : memo + 1}
      end
      
      def sum(attribute)
        lambda{|memo,t| memo.nil? ? 0 : memo + t[attribute]}
      end
    
    end # module Algebra
  end # module Engine
end # module Veritas