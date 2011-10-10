# encoding: utf-8

require 'spec_helper'

describe Algebra::Difference, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:header) { [ [ :id, Integer ] ]             }
  let(:left)   { Relation.new(header, [ [ 1 ] ])  }
  let(:object) { described_class.new(left, right) }
  let(:yields) { []                               }

  context 'with relations having similar bodies' do
    let(:right) { left.dup }

    it_should_behave_like 'an #each method'

    it 'yields no tuples' do
      expect { subject }.to_not change { yields.dup }
    end
  end

  context 'with relations having different bodies' do
    let(:right) { Relation.new(header, [ [ 2 ] ]) }

    it_should_behave_like 'an #each method'

    it 'yields each tuple' do
      expect { subject }.to change { yields.dup }.
        from([]).
        to([ [ 1 ] ])
    end
  end
end
