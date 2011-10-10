# encoding: utf-8

require 'spec_helper'

describe Relation, '.new' do
  subject { object.new(header, body) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { described_class                            }

  context 'with an Enumerable responding to #size' do
    let(:body) { [ [ 1 ] ] }

    before do
      body.should respond_to(:size)
    end

    it { should be_instance_of(Relation::Materialized) }

    it { should == body }
  end

  context 'with an Enumerable that does not respond to #size' do
    let(:body) { [ [ 1 ] ].each }  # use an Enumerator

    before do
      body.should_not respond_to(:size)
    end

    it { should be_instance_of(object) }

    it { should == [ [ 1 ] ] }
  end
end
