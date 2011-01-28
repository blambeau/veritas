module Veritas
  module Engine
    module Algebra
      
      def rename(relation, renaming)
        if is_relation?(relation)
          relation.rename(renaming)
        else
          rename(renaming, relation)
        end
      end
      
      # Computes a relational projection
      def project(*args)
        if is_relation?(args.first)
          relation = args.shift
          is_relation!(relation) and are_attribute_names!(attributes = args.flatten)
          relation.project(attributes)
        else
          project(args.last, *args[0...-1])
        end
      end
      
      # Computes the reverse of a relational projection
      def allbut(relation, *attributes)
        attributes = relation.header.reject{|a| attributes.include?(a.name)}.collect{|a| a.name}
        project(relation, *attributes)
      end
    
      # Makes the n-ary union of relations
      def union(*relations)
        relations.all?{|r| is_relation!(r)}
        relations.inject(nil){|memo,r| memo.nil? ? r : memo.union(r)}
      end
    
      # Makes the n-ary join of relations
      def join(*relations)
        relations.all?{|r| is_relation!(r)}
        relations.inject(nil){|memo,r| memo.nil? ? r : memo.join(r)}
      end
      
      # Computes n-ary relation difference
      def minus(*relations)
        relations.all?{|r| is_relation!(r)}
        relations.inject(nil){|memo,r| memo.nil? ? r : memo.difference(r)}
      end
      
      # Makes a relation restriction
      def restrict(relation, where)
        is_relation!(relation)
        relation.restrict(&where)
      end
      
      # Computes (project (join relation right) relation.heading)
      def matching(relation, right)
        attributes = relation.header.collect{|a| a.name}
        (project (join relation, right), attributes)
      end
      
      def not_matching(relation, right)
        (minus relation, (matching relation, right))
      end
      
      # Summarizes a relation 
      def summarize(relation, by, adds)
        case relation
        when Symbol, Array
          summarize(by, relation, adds)
        else
          is_relation!(relation)
          case by
            when Veritas::Relation
              relation.summarize(by){|r|
                adds.each_pair{|name, agg| r.add(name, &agg) }
              }
            when Array
              summarize(relation, relation.project(by), adds)
            when Symbol
              summarize(relation, [ by ], adds)
          end
        end
      end
      
    end # module Algebra
  end # module Engine
end # module Veritas