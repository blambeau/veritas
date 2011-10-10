# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '.new' do
  subject { object.new(argument) }

  let(:object) { described_class }

  context 'with no arguments' do
    subject { object.new }

    it { should be_instance_of(object) }

    it { should be_empty }
  end

  context 'with an argument that responds to #to_ary and do not contain duplicates' do
    let(:argument) { [ [ :id ], [ :name ] ] }

    it { should be_instance_of(object) }

    it { should == argument }
  end

  context 'with an argument that responds to #to_ary and contain duplicates' do
    let(:argument) { [ [ :id ], [ :id ], [ :name ], [ :name ], [ :age ] ] }

    specify { expect { subject }.to raise_error(DuplicateAttributeError, 'duplicate attributes: id, name') }
  end

  context 'with an argument that does not respond to #to_ary' do
    let(:argument) { { :id => Integer } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
