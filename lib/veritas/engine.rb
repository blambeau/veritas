require 'test/unit/assertions'
require 'veritas/engine/debug'
require 'veritas/engine/checks'
require 'veritas/engine/algebra'
module Veritas
  module Engine
    include ::Test::Unit::Assertions
    include ::Veritas::Engine::Checks
    include ::Veritas::Engine::Algebra
    
    # Debugs a (relation-)value
    def debug(value)
      puts (is_relation?(value) ? value.to_tutorial_d : value.inspect)
    end
    
    # Creates a relation value with a header and array of tuples
    #
    # Example:
    #
    #   suppliers = Veritas::relation(:id => String, :name => String) {[
    #     {:id => 'S1', :name => 'Jones'},
    #     {:id => 'S2', :name => 'Smith'},
    #   ]}
    #
    def relation(header_hash, tuples = nil)
      header = valid_header!(header_hash)
      attributes = header.collect{|a| a.name}
      tuples = (tuples || yield).collect{|t| t.values_at(*attributes)}
      ::Veritas::Relation.new(header, tuples)
    end
    alias :Relation :relation
    
  end # module Engine
end # module Veritas