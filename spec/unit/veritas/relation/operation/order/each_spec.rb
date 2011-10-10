# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id].desc ]                                      }
  let(:object)     { described_class.new(relation, directions)                   }
  let(:yields)     { []                                                          }

  it_should_behave_like 'an #each method'

  it 'yields each tuple in order' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 3 ], [ 2 ], [ 1 ] ])
  end
end
