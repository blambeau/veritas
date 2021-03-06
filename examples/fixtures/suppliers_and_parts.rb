module Veritas
  module Examples
    module SuppliersAndParts

      SUPPLIERS = Veritas::Engine::relation(:'S#' => String, :SNAME => String, :STATUS => Integer, :CITY => String) {[
        {:'S#' => 'S1', :SNAME => 'Smith', :STATUS => 20, :CITY => 'London'},
        {:'S#' => 'S2', :SNAME => 'Jones', :STATUS => 10, :CITY => 'Paris'},
        {:'S#' => 'S3', :SNAME => 'Blake', :STATUS => 30, :CITY => 'Paris'},
        {:'S#' => 'S4', :SNAME => 'Clark', :STATUS => 20, :CITY => 'London'},
        {:'S#' => 'S5', :SNAME => 'Adams', :STATUS => 30, :CITY => 'Athens'}
      ]}

      PARTS = Veritas::Engine::relation(:'P#' => String, :PNAME => String, :COLOR => String, :WEIGHT => Float, :CITY => String) {[
        {:'P#' => 'P1', :PNAME => 'Nut',   :COLOR => 'Red',   :WEIGHT => 12.0, :CITY => 'London'},
        {:'P#' => 'P2', :PNAME => 'Bolt',  :COLOR => 'Green', :WEIGHT => 17.0, :CITY => 'Paris'},
        {:'P#' => 'P3', :PNAME => 'Screw', :COLOR => 'Blue',  :WEIGHT => 17.0, :CITY => 'Oslo'},
        {:'P#' => 'P4', :PNAME => 'Screw', :COLOR => 'Red',   :WEIGHT => 14.0, :CITY => 'London'},
        {:'P#' => 'P5', :PNAME => 'Cam',   :COLOR => 'Blue',  :WEIGHT => 12.0, :CITY => 'Paris'},
        {:'P#' => 'P6', :PNAME => 'Cog',   :COLOR => 'Red',   :WEIGHT => 19.0, :CITY => 'London'},
      ]}

      SUPPLIES = Veritas::Engine::relation(:'S#' => String, :'P#' => String, :QUANTITY => Integer){[
        {:'S#' => 'S1', :'P#' => 'P1', :QUANTITY => 300},
        {:'S#' => 'S1', :'P#' => 'P2', :QUANTITY => 200},
        {:'S#' => 'S1', :'P#' => 'P3', :QUANTITY => 400},
        {:'S#' => 'S1', :'P#' => 'P4', :QUANTITY => 200},
        {:'S#' => 'S1', :'P#' => 'P5', :QUANTITY => 100},
        {:'S#' => 'S1', :'P#' => 'P6', :QUANTITY => 100},
        {:'S#' => 'S2', :'P#' => 'P1', :QUANTITY => 300},
        {:'S#' => 'S2', :'P#' => 'P2', :QUANTITY => 400},
        {:'S#' => 'S3', :'P#' => 'P2', :QUANTITY => 200},
        {:'S#' => 'S4', :'P#' => 'P2', :QUANTITY => 200},
        {:'S#' => 'S4', :'P#' => 'P4', :QUANTITY => 300},
        {:'S#' => 'S4', :'P#' => 'P5', :QUANTITY => 400}
      ]}
      
    end # module SuppliersAndParts
  end # module Examples
end # module Veritas