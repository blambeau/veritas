module Veritas
  module Engine
    module Ast
      
      ### NAMING AND LIST TOOLS
      
      #
      module RelationExprList
        
        def compile(*args)
          [ head.compile(*args) ] + tail.matches.collect{|z| z.compile(*args)}
        end
        
      end # module RelationExprList
      
      #
      module AttributeNameList
        
        def compile(*args)
          [ head.value ] + tail.matches.collect{|z| z.last.value}
        end
        
      end # module RelationExprList
      
      
      ### RELATIONAL ALGEBRA
      
      #
      module Allbut
        
        def compile(*args)
          Veritas::Engine::allbut(operand.compile(*args), *attributes.value)
        end
        
      end # module Allbut
      
      #
      module Intersect
        
        def compile(*args)
          Veritas::Engine::intersect(operand.compile(*args))
        end
        
      end # module Allbut
      
      #
      module Join
        
        def compile(*args)
          # TODO
        end
        
      end # module Join
      
      #
      module Minus
        
        def compile(*args)
          # TODO
        end
        
      end # module Minus
      
      #
      module Project
        
        def compile(*args)
          # TODO
        end
        
      end # module Project
      
      #
      module Rename
        
        def compile(*args)
          # TODO
        end
        
      end # module Rename
      
      #
      module Union
        
        def compile(*args)
          # TODO
        end
        
      end # module Union
      
      #
      module RelationRef
        
        def compile(*args)
          Relation.new( [ [ :name, String ] ], [ ] )
        end
        
      end # module RelationRef
      
    end # module Ast
  end # module Engine
end # module Veritas