# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#each' do
  subject { object.each { |direction| yields << direction } }

  let(:attributes) { [ Attribute::Integer.new(:id), Attribute::String.new(:name) ] }
  let(:object)     { described_class.new(attributes)                               }
  let(:yields)     { []                                                            }

  it_should_behave_like 'an #each method'

  it 'yields each direction' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to(attributes.map { |attribute| attribute.asc })
  end
end

describe Relation::Operation::Order::DirectionSet do
  subject { object.new(attributes) }

  let(:attributes) { [ Attribute::Integer.new(:id) ]          }
  let(:object)     { Relation::Operation::Order::DirectionSet }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end
