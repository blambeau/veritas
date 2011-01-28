begin
  require "request_log_analyzer"
rescue LoadError => ex
  raise "Veritas::Physical::Logs relies external gem. Try 'gem install request-log-analyzer'"
end
module Veritas
  module Physical
    class Logs < Relation
      
      class Decoder
        include Enumerable
        
        attr_reader :files
        attr_reader :heading
        attr_reader :file_format
        
        def initialize(files, file_format, heading)
          @files = [ files ].flatten
          @file_format = file_format
          @heading = heading
        end
        
        def each
          parser = RequestLogAnalyzer::Source::LogParser.new(file_format)
          parser.parse_files(files) do |req|
            yield req_to_tuple(req)
          end
        end
        
        def req_to_tuple(req)
          attrs = req.attributes
          @heading.collect{|pair| attrs[pair[0]]}
        end
        
      end
      
      def initialize(files, file_format, line_def = :access)
        case file_format
        when RequestLogAnalyzer::FileFormat
        when Symbol
          file_format = RequestLogAnalyzer::FileFormat.load(file_format)
        when Array
          file_format = RequestLogAnalyzer::FileFormat.load(*file_format)
        else 
          raise ArgumentError, "Invalid file format: #{file_format}"
        end
        heading = infer_heading(file_format, line_def)
        super(heading, Decoder.new(files, file_format, heading))
      end
      
      private
      
      LOG_TYPES = {
        # RequestLogAnalyzer::Request::Converters
        :string          => String,
        :float           => Float,
        :decimal         => Float,
        :int             => Integer,
        :integer         => Integer,
        :sym             => Symbol,
        :symbol          => Symbol,
        :timestamp       => Integer,
        :traffic         => Integer,
        :duration        => Float,
        :epoch           => Integer,
        # AmazonS3
        :nillable_string => String,
        :referer         => String,
        :user_agent      => String,
        # Apache
        :path            => String,
        # MySQL
        :sql             => String
      }
      
      def infer_heading(format, line_def)
        format.line_definitions[line_def].captures.collect{|capt|
          [ capt[:name], to_type(capt[:type]) ]
        }
      end
      
      def to_type(log_type)
        LOG_TYPES[log_type] || String
      end

    end # class Logs
  end # module Physical
end # module Veritas