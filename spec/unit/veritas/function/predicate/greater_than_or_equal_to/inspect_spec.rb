# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::GreaterThanOrEqualTo, '#inspect' do
  subject { object.inspect }

  let(:attribute) { Attribute::Integer.new(:id)       }
  let(:object)    { described_class.new(attribute, 1) }

  it { should == "(#{attribute.inspect} >= 1)" }
end
