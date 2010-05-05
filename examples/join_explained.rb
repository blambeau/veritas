require File.expand_path('../commons', __FILE__)
include ::Veritas::Examples::SuppliersAndParts

###############################################################################
# 1) Non-common usage of JOIN
###############################################################################
# Joins are powerful... maybe the most powerful operator! Remember the following
# query: 
#
# Is there any suppliers living Paris? YES -> display it
#
# Here is one way:
# interesting = 'Paris'.to_rel(:CITY) 
interesting = Relation(:CITY => String){[{:CITY => 'Paris'}]}
(debug (join SUPPLIERS, interesting))
