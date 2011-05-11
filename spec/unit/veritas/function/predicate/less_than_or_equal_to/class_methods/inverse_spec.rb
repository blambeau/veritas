require 'spec_helper'

describe Function::Predicate::LessThanOrEqualTo, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Predicate::GreaterThan) }
end
