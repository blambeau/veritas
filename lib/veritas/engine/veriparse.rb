require 'rubygems'
require 'citrus'
require 'veritas/engine'
module Veritas
  module Engine
    
    # Load the grammar
    require File.expand_path('../ast', __FILE__)
    Citrus.load File.expand_path('../veriparse', __FILE__)
    
    def self.parse(text)
      Veriparse.parse(text)
    end
    
  end
end

if $0 == __FILE__
  require 'test/unit'
  class Veritas::Engine::VeriparseProductionTest < Test::Unit::TestCase
    
    def parse(text, rule)
      Veritas::Engine::Veriparse.parse(text, {:memoize => true, :root => rule})
    end
    
    def compile(text, rule)
      parse(text, rule).compile
    end
    
    def test_allbut
      assert_kind_of Veritas::Algebra::Projection, compile("(allbut XXX a, b)", :relation_allbut)
    end
    
    def test_attribute_name_list
      assert_equal [:a], compile("a", :attribute_name_list)
      assert_equal [:a, :b], compile("a b", :attribute_name_list)
      assert_equal [:a, :b, :c], compile("a, b, c", :attribute_name_list)
    end
    
  end
  class Veritas::Engine::VeriparseParserTest < Test::Unit::TestCase
    
    def parse(text, rule)
      Veritas::Engine::Veriparse.parse(text, {:memoize => true, :root => rule})
    end
    
    def assert_parse(text, rule)
      assert_nothing_raised{ 
        parse(text, rule)
      }
    end
    
    def test_relation_join
      assert_parse("(join XXX YYY)", :relation_join)
      assert_parse("(join XXX YYY ZZZ)", :relation_join)
      assert_parse("(join XXX, YYY)", :relation_join)
      assert_parse("(join (join XXX YYY) ZZZ)", :relation_join)
      assert_parse("(join (join XXX YYY), ZZZ)", :relation_join)
    end
    
    def test_relation_union
      assert_parse("(union XXX YYY)", :relation_union)
      assert_parse("(union XXX YYY ZZZ)", :relation_union)
      assert_parse("(union XXX, YYY)", :relation_union)
      assert_parse("(union (join XXX YYY) ZZZ)", :relation_union)
      assert_parse("(union (join XXX YYY), ZZZ)", :relation_union)
    end
    
    def test_relation_intersect
      assert_parse("(intersect XXX YYY)", :relation_intersect)
      assert_parse("(intersect XXX YYY ZZZ)", :relation_intersect)
      assert_parse("(intersect XXX, YYY)", :relation_intersect)
      assert_parse("(intersect (join XXX YYY) ZZZ)", :relation_intersect)
      assert_parse("(intersect (join XXX YYY), ZZZ)", :relation_intersect)
    end
    
    def test_relation_minus
      assert_parse("(minus XXX YYY)", :relation_minus)
      assert_parse("(minus XXX YYY ZZZ)", :relation_minus)
      assert_parse("(minus XXX, YYY)", :relation_minus)
      assert_parse("(minus (join XXX YYY) ZZZ)", :relation_minus)
      assert_parse("(minus (join XXX YYY), ZZZ)", :relation_minus)
    end
    
    def test_relation_project
      assert_parse("(project XXX)", :relation_project)
      assert_parse("(project XXX attr1)", :relation_project)
      assert_parse("(project (rename XXX y:z) attr1)", :relation_project)
      assert_parse("(project XXX attr1, attr2)", :relation_project)
      assert_parse("(project XXX attr1 attr2)", :relation_project)
      assert_parse("(project XXX attr1 attr2 attr3 )", :relation_project)
    end
    
    def test_relation_allbut
      assert_parse("(allbut XXX)", :relation_allbut)
      assert_parse("(allbut XXX attr1)", :relation_allbut)
      assert_parse("(allbut (rename XXX y:z) attr1)", :relation_allbut)
      assert_parse("(allbut XXX attr1, attr2)", :relation_allbut)
      assert_parse("(allbut XXX attr1 attr2)", :relation_allbut)
      assert_parse("(allbut XXX attr1 attr2 attr3 )", :relation_allbut)
    end
    
    def test_relation_rename
      assert_parse("(rename XXX old:new)", :relation_rename)
      assert_parse("(rename XXX old: new)", :relation_rename)
      assert_parse("(rename XXX time: spent, count: total)", :relation_rename)
      assert_parse("(rename (rename XXX old:new) time: spent, count: total)", :relation_rename)
    end
  
    def test_boolean
      assert_equal true, Kernel.eval(parse("true", :BOOLEAN))
      assert_equal false, Kernel.eval(parse("false", :BOOLEAN))
    end
  
    def test_float
      [ "0.0", "+0.0", "-0.0", "12.0", "-12.0", "+12.0" ].each{|p| 
        assert_equal p.to_f, parse(p, :FLOAT).to_f
      }
    end
  
    def test_integer
      [ "0", "+0", "-0", "12", "-12", "+12", "1_000_000" ].each{|p| 
        assert_equal p.to_i, parse(p, :INTEGER).to_i
      }
    end
      
    def test_double_quoted_string
      [ %q{""}, %q{"hello"}, %q{"O\"Neil"} ].each{|p| 
        assert_nothing_raised{ parse(p, :DOUBLE_QUOTED_STRING) }
      }
    end
      
    def test_single_quoted_string
      [ %q{''}, %q{'hello'}, %q{'O\'Neil'} ].each{|p| 
        assert_nothing_raised{ parse(p, :SINGLE_QUOTED_STRING) }
      }
    end
      
    def test_lexsymbol
      [ "a", "hello", "hello_world", "empty?", "merge!" ].each{|p| 
        assert_nothing_raised{ parse(p, :LEXSYMBOL) }
      }
    end
      
    def test_module
      [ "::A", "A", "Hello", "HelloWorld", "Hello::World", "::Hello::World" ].each{|p| 
        assert_nothing_raised{ parse(p, :MODULE) }
      }
    end
    
  end # class Veritas::Engine::VeriparseTest
end