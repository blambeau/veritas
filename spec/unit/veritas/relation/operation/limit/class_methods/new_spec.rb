require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit.new' do
  let(:original_relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  subject { Relation::Operation::Limit.new(relation, 1) }

  context 'with an ordered relation' do
    let(:relation) { original_relation.order { |r| r[:id] } }

    it { should be_kind_of(Relation::Operation::Limit)  }
  end

  context 'without an ordered relation' do
    let(:relation) { original_relation }

    specify { method(:subject).should raise_error(OrderedRelationRequiredError, 'can only limit an ordered relation') }
  end
end
