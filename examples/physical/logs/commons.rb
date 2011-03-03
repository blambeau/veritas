require File.expand_path('../../../commons', __FILE__)
require 'veritas/physical/logs'
files = Dir[File.expand_path('../access.*', __FILE__)]
LOGS = Veritas::Physical::Logs.new(files, [:apache, :combined])

