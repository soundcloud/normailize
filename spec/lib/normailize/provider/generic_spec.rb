require 'spec_helper'

describe Normailize::Provider::Generic do
  subject { Normailize::Provider::Generic.new('somewhere.com') }

  it 'includes the Provider module' do
    subject.should be_a(Normailize::Provider)
  end

  it 'is a generic provider' do
    subject.should be_generic
  end

  describe '.domains' do
    subject { Normailize::Provider::Generic.domains }

    it 'does not include any domains' do
      subject.should be_nil
    end
  end

  describe '#modifications' do
    subject { Normailize::Provider::Generic.new('somewhere.com').modifications }

    it 'lowercases emails' do
      subject.should include(:lowercase)
    end

    it 'removes plus parts' do
      subject.should include(:remove_plus_part)
    end
  end

  describe '#same_as?' do
    context 'when comparing a provider of the same type' do
      it 'returns true' do
        subject.same_as?(Normailize::Provider::Generic.new('somewhere.com')).should be_true
      end
    end

    context 'when comparing a generic provider with a different domain' do
      it 'returns false' do
        subject.same_as?(Normailize::Provider::Generic.new('somewhereelse.com')).should be_false
      end
    end

    context 'when comparing a Gmail provider' do
      it 'returns false' do
        subject.same_as?(Normailize::Provider::Gmail.new('gmail.com')).should be_false
      end
    end
  end
end
