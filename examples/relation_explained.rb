require File.expand_path('../commons', __FILE__)

###############################################################################
# 1) Relation literals as array of Ruby hashes
###############################################################################
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

###############################################################################
# 2) A relation is a SET ... and sets do not contain duplicates!
###############################################################################
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
# sense to write relation literals containing duplicates, but Veritas is friendly
# and removes duplicates instead of raising an error!

###############################################################################
# 3) A relation is a SET ... and sets are not ordered
###############################################################################
# At first glance only! Unlike an array, a relation is not ordered, it's just
# a set of tuples... So the following relations are equal:
c1 = Relation(:NAME => String){[{:NAME => 'London'}, {:NAME => 'Paris'}]}
c2 = Relation(:NAME => String){[{:NAME => 'Paris'}, {:NAME => 'London'}]}
(assert_equal c1, c2)

###############################################################################
# 4) A relation has a heading ... and that heading is typed
###############################################################################
# At first glance! A relation is also typed, by definition! Therefore, unlike
# arrays, a relation may not contain tuples not conforming to its heading:
assert_raise RelationMismatchError do
  Relation(:NAME => String){[
    {:NAME => 12}
  ]}
end
assert_raise RelationMismatchError do
  Relation(:NAME => String){[
    {:PRICE => 12.0}
  ]}
end
assert_raise RelationMismatchError do
  Relation(:NAME => String){[
    {:NAME => "London", :PRICE => 12.0}
  ]}
end

###############################################################################
# 5) A relation contains values ... and NULL is not a value
###############################################################################
# Also, NULL values lead to a lot of mathematical inconsistencies so that NULL
# values are not accepted inside relations...
assert_raise RelationMismatchError do
  Relation(:NAME => String){[
    {:NAME => nil}
  ]}
end
### What about the NULL/NIL debate inside Veritas??

###############################################################################
# 5) Relations and tuples are sets ... and empty sets exist
###############################################################################
# Last, but not least, there are two (not-so) special relations: TABLE_DEE and 
# TABLE_DUM. Both have an empty heading (no attribute at all), the former having 
# exactly one tuple  and the later having no tuple at all:
assert_equal TABLE_DEE, Relation(){ [ {} ] }
assert_equal TABLE_DUM, Relation(){}

