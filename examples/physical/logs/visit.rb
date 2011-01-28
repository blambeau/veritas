require File.expand_path('../commons', __FILE__)
require "yargi"

class QueryToDot
  
  # Dot attributes for an operator
  OPERATOR = {:shape => :octagon, :height => 0.1}
  
  # Dot attributes for a leaf relation
  LEAF = {:shape => :box3d, :height => 0.3}
  
  # Dot attributes for operator parameters
  PARAMS = {:shape => :component}
  
  # Returns the name of a Relation node.
  def nameof(rel)
    rel.class.name.split('::').last
  end
  
  # Adds a vertex to the graph
  def add_graph_vertex(attrs)
    vertex = @graph.add_vertex(attrs)
    yield(vertex) if block_given?
    vertex
  end
  
  # Connects two vertices
  def connect(source, target, label)
    @graph.connect(source, target, :label => label)
  end
  
  def self.visit(relation)
    self.new.visit(relation)
  end
  
  def visit(node)
    @graph = Yargi::Digraph.new
    _visit(node)
    @graph
  end
  
  # Visit a node
  def _visit(node)
    method = :"_visit_#{nameof(node).downcase}"
    if self.respond_to?(method)
      self.send(method, node)
    else
      add_graph_vertex(LEAF.merge(:label => nameof(node)))
    end
  end
  
  def _visit_binary(node)
    attrs = OPERATOR.merge(:label => nameof(node))
    add_graph_vertex(attrs){|gn|
      connect(gn, _visit(node.left), :left)
      connect(gn, _visit(node.right), :right)
    }
  end
  alias :_visit_difference :_visit_binary
  alias :_visit_intersection :_visit_binary
  alias :_visit_product :_visit_binary
  alias :_visit_union :_visit_binary
  alias :_visit_join :_visit_binary
  
  def _visit_rename(node)
    attrs = OPERATOR.merge(:label => nameof(node))
    add_graph_vertex(attrs){|gn|
      connect(gn, _visit(node.operand), :operand)
      renaming = node.aliases.collect{|pair| pair.collect{|a| a.name}.join(': ')}
      renaming = add_graph_vertex(PARAMS.merge(
        :label => renaming.join('\n')
      ))
      connect(gn, renaming, :renaming)
    }
  end
  
  def _visit_projection(node)
    attrs = OPERATOR.merge(:label => nameof(node))
    add_graph_vertex(attrs){|gn|
      connect(gn, _visit(node.operand), :operand)
      header = node.header.collect{|a| a.name}
      header = (header.size > 4) ? (header[0..2] + [ "..." ]) : header
      header = add_graph_vertex(PARAMS.merge(
        :label => header.join('\n')
      ))
      connect(gn, header, :attributes)
    }
  end
  
  def _visit_restriction(node)
    attrs = OPERATOR.merge(:label => nameof(node))
    add_graph_vertex(attrs){|gn|
      connect(gn, _visit(node.operand), :operand)
      predicate = add_graph_vertex(PARAMS.merge(
        :label => nameof(node.predicate)
      ))
      connect(gn, predicate, :predicate)
    }
  end
  
  def _visit_summarization(node)
    attrs = OPERATOR.merge(:label => nameof(node))
    add_graph_vertex(attrs){|gn|
      connect(gn, _visit(node.operand), :operand)
      connect(gn, _visit(node.summarize_by), :by)
      summarizers = node.summarizers.keys.collect{|a| "#{a.name}: ..."}
      summarizers = (summarizers.size > 4) ? (summarizers[0..2] + [ "..." ]) : summarizers
      summarizers = add_graph_vertex(PARAMS.merge(
        :label => summarizers.join('\n')
      ))
      connect(gn, summarizers, :summarizers)
    }
  end
  
end

# Let's take the last query, but inline and using the not_matching operator
q = (rename Hash[:count => :nb_hits, :time => :min_time],
      (summarize :path,
        (not_matching LOGS, 
          (project :user_agent,
            (restrict LOGS, ->(t){ t[:path].match(/robots.txt/) }))),
        Hash[:count => (count '*'), :time => (min :timestamp), :weight => (sum :bytes_sent)]))
puts QueryToDot.visit(q).to_dot
