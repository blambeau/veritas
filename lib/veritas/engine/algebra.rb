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
    
    end # module Algebra
  end # module Engine
end # module Veritas