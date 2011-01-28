module Veritas
  module Engine
    module Algebra
      
      # Computes a relational projection
      def project(relation, *attributes)
        is_relation!(relation) and are_attribute_names!(attributes = attributes.flatten)
        relation.project(attributes)
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
      
      def minus(*relations)
        relations.all?{|r| is_relation!(r)}
        relations.inject(nil){|memo,r| memo.nil? ? r : memo.difference(r)}
      end
      
      # Makes a relation restriction
      def restrict(relation, where)
        is_relation!(relation)
        relation.restrict(&where)
      end
      
      def summarize(relation, by, adds)
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
      
      def count(*args)
        lambda{|memo,t| memo.nil? ? 1 : memo + 1}
      end
      
      def sum(attribute)
        lambda{|memo,t| memo.nil? ? 0 : memo + t[attribute]}
      end
    
    end # module Algebra
  end # module Engine
end # module Veritas