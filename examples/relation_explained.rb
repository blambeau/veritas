require File.expand_path('../commons', __FILE__)

# At first glance, a relation looks like an array of hashes:
[
  {:NAME => 'London'},
  {:NAME => 'Paris'},
  {:NAME => 'Bruxelles'}
]

# And, in fact, the Veritas engine allows array of hashes to be used as relation 
# literals (like the text '12' is used in source code as an integer literal):
cities = Relation(:NAME => String){[
  {:NAME => 'London'},
  {:NAME => 'Paris'},
  {:NAME => 'Bruxelles'}
]}
(debug cities)

# At first glance only! Unlike an array, a relation is mathematically defined
# as a SET of tuples and, by definition, it never contains duplicates:
assert_equal 4, [
 {:NAME => 'London'},
 {:NAME => 'Paris'},
 {:NAME => 'London'},
 {:NAME => 'Bruxelles'}].size
 
assert_equal 3, Relation(:NAME => String){[
  {:NAME => 'London'},
  {:NAME => 'Paris'},
  {:NAME => 'London'},
  {:NAME => 'Bruxelles'}
]}.size 
# Of course, the former example is a bit contrived... it does not really make 
# sense to write relation literals containing duplicates, but Veritas engine is
# frienly here and removes duplicates instead of raising an error!

# At first glance! A relation is also typed, by definition! Therefore, unlike
# arrays, a relation may not contain tuples not conforming to its heading:
assert_raise ArgumentError do
  Relation(:NAME => String){[
    {:NAME => 12}
  ]}
end
assert_raise ArgumentError do
  Relation(:NAME => String){[
    {:PRICE => 12.0}
  ]}
end
assert_raise ArgumentError do
  Relation(:NAME => String){[
    {:NAME => "London", :PRICE => 12.0}
  ]}
end
# TODO: fix the engine to conform the specification here
