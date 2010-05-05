require File.expand_path('../commons', __FILE__)
include ::Veritas::Examples::SuppliersAndParts

###############################################################################
# 1) Projecting a relation is "selecting" specific attributes only
###############################################################################
# Projecting a relation returns another relation without specific attributes:
# For example, projecting the suppliers relation on the supplier number and name:
expected = Relation(:'S#' => String, :SNAME => String) {[
  {:'S#' => 'S1', :SNAME => 'Smith'},
  {:'S#' => 'S2', :SNAME => 'Jones'},
  {:'S#' => 'S3', :SNAME => 'Blake'},
  {:'S#' => 'S4', :SNAME => 'Clark'},
  {:'S#' => 'S5', :SNAME => 'Adams'}
]}
(assert_equal expected, project(SUPPLIERS, :'S#', :SNAME))

###############################################################################
# 2) Projecting a relation returns a relation ... without duplicates
###############################################################################
# As a relation is a set it does not contain duplicates (see relation_explained.rb)
# Therefore, as projecting a relation returns a relation, the later does never 
# contain duplicates (unlike SELECT * FROM).

#
# In our examples, there are 5 suppliers leaving in 3 different cities only:

# The following is not permitted by Veritas so far...
# (assert_equal 5, SUPPLIERS.size)
# (assert_equal 4, (project SUPPLIERS, :CITY).size)

expected = Relation(:CITY => String){[
  {:CITY => 'London'},
  {:CITY => 'Athens'},
  {:CITY => 'Paris'},
]}
(assert_equal expected, (project SUPPLIERS, :CITY))

###############################################################################
# 3) Expressing one thing should be as easy as expressing its reverse
###############################################################################
# What if one wants to "remove" attributes instead of selecting the others?
# ALLBUT is an operator which acts logically the reverse way:
(assert_equal (project SUPPLIERS, :'S#', :SNAME), 
              (allbut  SUPPLIERS, :STATUS, :CITY))
              
###############################################################################
# 4) Maybe strangly, it makes sense to project over no attribute at all
###############################################################################
# When the relation contains at least one tuple, it leads to TABLE_DEE
(assert_equal TABLE_DEE, (project SUPPLIERS))
(assert_equal TABLE_DEE, (allbut SUPPLIERS, *SUPPLIERS.header.collect{|a| a.name}))

# Otherwise, it leads to TABLE_DUM
(assert_equal TABLE_DUM, (project Relation(SUPPLIERS.header){}))

###############################################################################
# 5) Logic and projections
###############################################################################
# Why some strange projection constructions? Two main reasons: 
# 1) projecting over no attribute is required for mathematical soundness of the 
#    theory...
# 2) TABLE_DEE and TABLE_DUM can be seen as the truth values of the relational
#    algebra:
#
# The relational algebra is rooted in first order logic. Following the "closed 
# world assumption" (tuples inside the database are known facts considered true,
# missing tuples are considered false, and relational algebra is the fact 
# derivation mechanism), the query below can be rephrased as "Is there any supplier 
# in the database?"
#
(project SUPPLIERS)
#
# The answer is true (TABLE_DEE) if there is at least on tuple in the suppliers
# relation (variable), false (TABLE_DUM) otherwise!
#
# In other words, the following constructs (not allowed by Veritas so far) are
# equivalent:
#
# SUPPLIERS.empty? == (SUPPLIERS.size==0) == (TABLE_DUM == (project SUPPLIERS))

# Is there any suppliers living Oslo? NO -> TABLE_DUM
assert_equal TABLE_DUM, (project SUPPLIERS.restrict{|t| t[:CITY].eq('Oslo')})

# Is there any suppliers living London? YES -> TABLE_DEE
assert_equal TABLE_DEE, (project SUPPLIERS.restrict{|t| t[:CITY].eq('London')})
