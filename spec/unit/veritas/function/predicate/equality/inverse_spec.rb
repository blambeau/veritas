# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Equality, '#inverse' do
  subject { object.inverse }

  let(:attribute) { Attribute::Integer.new(:id)       }
  let(:object)    { described_class.new(attribute, 1) }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Function::Predicate::Inequality) }

  its(:left) { should equal(attribute) }

  its(:right) { should == 1 }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
