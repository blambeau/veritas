module UnaryOperationSpecs
  class Object < Relation
    include Relation::Operation::Unary

    def each(&block)
      operand.each(&block)
      self
    end

  end # class Object
end # module UnaryOperationSpecs
