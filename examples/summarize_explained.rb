require File.expand_path('../commons', __FILE__)
include ::Veritas::Examples::SuppliersAndParts

s = (summarize_by SUPPLIES, project(SUPPLIES, :'S#'),
  :COUNT     => (count :'S#'),
  :TOTAL_QTY => (sum   :QUANTITY) 
)
(debug s)