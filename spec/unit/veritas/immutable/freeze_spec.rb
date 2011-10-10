# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Immutable, '#freeze' do
  subject { object.freeze }

  let(:described_class) { Class.new(ImmutableSpecs::Object) }

  before do
    described_class.memoize(:test)
  end

  context 'with an unfrozen object' do
    let(:object) { described_class.allocate }

    it { should equal(object) }

    it 'freezes the object' do
      expect { subject }.to change(object, :frozen?).
        from(false).
        to(true)
    end

    it 'sets a memoization instance variable' do
      object.should_not be_instance_variable_defined(:@__memory)
      subject
      object.instance_variable_get(:@__memory).should be_instance_of(Hash)
    end
  end

  context 'with a frozen object' do
    let(:object) { described_class.new }

    it { should equal(object) }

    it 'does not change the frozen state of the object' do
      expect { subject }.to_not change(object, :frozen?)
    end

    it 'does not change the memoization instance variable' do
      expect { subject }.to_not change { object.instance_variable_get(:@__memory) }
    end

    it 'sets an instance variable for memoization' do
      subject.instance_variable_get(:@__memory).should be_instance_of(Hash)
    end
  end
end
