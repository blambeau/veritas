require File.expand_path('../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::AbstractClass#new' do
  context 'called on class' do
    subject { AbstractClassSpecs::Object.new }

    specify { method(:subject).should raise_error(NotImplementedError, 'AbstractClassSpecs::Object is an abstract class') }
  end

  context 'called on subclass' do
    subject { AbstractClassSpecs::Subclass.new }

    it { should be_kind_of(AbstractClassSpecs::Subclass) }
  end
end
