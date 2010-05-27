require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Methods#directions' do
  subject { relation.directions }

  let(:relation) { Relation.new([ [ :id, Integer ] ], []) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should be_empty }

  it 'is consistent' do
    should equal(relation.directions)
  end
end