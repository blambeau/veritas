module Veritas
  class Relation
    class Header
      def to_tutorial_d
        collect{|a| "#{a.class.name.gsub('Veritas::Attribute::', '')} #{a.name}"}.join(", ")
      end
      alias :inspect :to_tutorial_d
    end
    # Returns a tutorial-d like inspect string
    def to_tutorial_d
      h = header.to_tutorial_d
      d = self.collect{|t| t.to_tutorial_d}.join("\n  ")
      "RELATION{#{h}}{\n  #{d}\n}"
    end
    alias :inspect :to_tutorial_d
  end
  class Tuple
    # Returns a tutorial-d like inspect string
    def to_tutorial_d
      s = header.collect{|a| "#{a.name} #{self.[](a.name).inspect}"}.join(", ")
      "TUPLE{#{s}}"
    end
    alias :inspect :to_tutorial_d
  end
end