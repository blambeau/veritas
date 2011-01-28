require File.expand_path('../../../commons', __FILE__)
require 'veritas/physical/logs'
file = File.expand_path('../access.log', __FILE__)
LOGS = Veritas::Physical::Logs.new(file, [:apache, :combined])

