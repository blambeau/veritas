# encoding: utf-8

require 'spec_helper'

describe Attribute, '.descendants' do
  subject { object.descendants }

  let(:object) { Class.new(described_class) }

  context 'when there are no descendants' do
    it_should_behave_like 'an idempotent method'

    it { should be_empty }
  end

  context 'when there are descendants' do
    let!(:descendant) { Class.new(object) }

    it_should_behave_like 'an idempotent method'

    it { should eql([ descendant ]) }
  end
end
