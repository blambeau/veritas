# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#inspect' do
  subject { object.inspect }

  let(:attribute) { [ :id, Integer ]                   }
  let(:object)    { described_class.new([ attribute ]) }

  it { should be_instance_of(String) }

  it { should == '[<Attribute::Integer name: id>]' }
end
