# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Comparable, '#inspect' do
  subject { object.inspect }

  let(:described_class) { PredicateComparableSpecs::Object        }
  let(:left)            { mock('Function', :inspect => '<left>')  }
  let(:right)           { mock('Function', :inspect => '<right>') }
  let(:object)          { described_class.new(left, right)        }

  it { should == '(<left> == <right>)' }
end
