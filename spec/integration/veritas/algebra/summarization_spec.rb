require 'spec_helper'

describe 'Veritas::Algebra::Summarization' do
  context 'summarize on the same set' do
    subject { relation.summarize(by){|r| r.add(:count){|m,t| m.nil? ? 1 : m+1} } }

    let(:relation) { Relation.new([ [ :name, String ], [ :qty, Integer ] ], [ [ 'Dan Kubb', 1 ], [ 'John Doe', 1 ] ])  }
    let(:by)       { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ], [ 'John Doe' ]  ]) }    

    it 'returns a relation with a single tuple' do
      should == [ [ 'Dan Kubb', 1 ], [ 'John Doe', 1 ] ]
    end
  end
  context 'summarize on an smaller set' do
    subject { relation.summarize(by){|r| } }

    let(:relation) { Relation.new([ [ :name, String ], [ :qty, Integer ] ], [ [ 'Dan Kubb', 1 ], [ 'John Doe', 1 ] ]) }
    let(:by)       { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ]) }    

    it 'returns a relation with a single tuple' do
      should == [ [ 'Dan Kubb', 1 ] ]
    end
  end
  context 'summarize on an larger set' do
    subject { relation.summarize(by){|r| } }

    let(:relation) { Relation.new([ [ :name, String ], [ :qty, Integer ] ], [ [ 'Dan Kubb', 1 ], [ 'John Doe', 1 ] ]) }
    let(:by)       { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ], [ 'Dane Largy' ] ]) }    

    it 'returns a relation with a single tuple' do
      should == [ [ 'Dan Kubb', 1 ], [ 'Dane Largy', 0 ] ]
    end
  end
end
