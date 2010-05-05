require 'test/unit/assertions'
require 'veritas/engine/debug'
require 'veritas/engine/checks'
require 'veritas/engine/literals'
require 'veritas/engine/algebra'
module Veritas
  module Engine
    include ::Test::Unit::Assertions
    include ::Veritas::Engine::Literals
    include ::Veritas::Engine::Checks
    include ::Veritas::Engine::Algebra
    
    # Debugs a (relation-)value
    def debug(value)
      puts (is_relation?(value) ? value.to_tutorial_d : value.inspect)
    end
    
    extend Engine
  end # module Engine
end # module Veritas