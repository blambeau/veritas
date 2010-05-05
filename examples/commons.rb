$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'veritas'
require 'veritas/engine'
include ::Veritas
include ::Veritas::Engine
require File.expand_path("../fixtures/suppliers_and_parts", __FILE__)