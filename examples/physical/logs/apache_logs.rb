require File.expand_path('../../../commons', __FILE__)
require 'veritas/physical/logs'

file = File.expand_path('../access.log', __FILE__)
format = RequestLogAnalyzer::FileFormat.load(:apache, :combined)
LOGS = Veritas::Physical::Logs.new(file, format)

(debug (project LOGS.restrict{|t| t[:http_status].eq(404)}, :path))