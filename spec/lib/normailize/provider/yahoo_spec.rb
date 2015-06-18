require 'spec_helper'

describe Normailize::Provider::Yahoo do
  subject { Normailize::Provider::Yahoo.new('yahoo.com') }

  it 'includes the Provider module' do
    subject.should be_a(Normailize::Provider)
  end

  it 'is not a generic provider' do
    subject.should_not be_generic
  end

  describe '.domains' do
    subject { Normailize::Provider::Yahoo.domains }

    it 'includes yahoo.com' do
      subject.should include('yahoo.com')
    end

    it 'includes yahoo.co.id' do
      subject.should include('yahoo.co.id')
    end
  end

  describe '#modifications' do
    subject { Normailize::Provider::Yahoo.new('yahoo.com').modifications }

    it 'lowercases email' do
      subject.should include(:lowercase)
    end

    it 'removes dash part' do
      subject.should include(:remove_dash_part)
    end
  end

  describe '#same_as?' do
    context 'when comparing a provider of the same type' do
      it 'returns true' do
        subject.same_as?(Normailize::Provider::Yahoo.new('yahoo.com')).should be_true
      end
    end

    context 'when comparing a generic provider' do
      it 'returns false' do
        subject.same_as?(Normailize::Provider::Generic.new('somewhere.com')).should be_false
      end
    end

    context 'when comparing a Gmail provider' do
      it 'returns false' do
        subject.same_as?(Normailize::Provider::Gmail.new('gmail.com')).should be_false
      end
    end
  end
end
