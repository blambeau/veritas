require 'spec_helper'

describe 'Veritas::Relation::Operation::Order.new' do
  subject { object.new(relation, directions) }

  let(:header)   { [ [ :id, Integer ], [ :name, String ] ]   }
  let(:body)     { [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ] }
  let(:relation) { Relation.new(header, body)                }
  let(:object)   { Relation::Operation::Order                }

  context 'with all attributes specified in the directions' do
    let(:directions) { [ relation[:id], relation[:name] ] }

    it { should be_kind_of(object) }

    its(:operand) { should equal(relation) }

    its(:directions) { should == [ relation[:id].asc, relation[:name].asc ] }
  end

  context 'without no attributes specified in the directions' do
    let(:directions) { [] }

    it { should be_kind_of(object) }

    its(:operand) { should equal(relation) }

    its(:directions) { should == [ relation[:id].asc, relation[:name].asc ] }
  end

  context 'without all attributes specified in the directions' do
    let(:directions) { [ :id ] }

    specify { expect { subject }.to raise_error(InvalidDirectionsError, 'directions must include every attribute in the header') }
  end
end
