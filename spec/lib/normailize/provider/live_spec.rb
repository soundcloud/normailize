require 'spec_helper'

describe Normailize::Provider::Live do
  subject { Normailize::Provider::Live.new('live.com') }

  it 'includes the Provider module' do
    subject.should be_a(Normailize::Provider)
  end

  it 'is not a generic provider' do
    subject.should_not be_generic
  end

  describe '.domains' do
    subject { Normailize::Provider::Live.domains }

    it 'includes live.com' do
      subject.should include('live.com')
    end
  end

  describe '#modifications' do
    subject { Normailize::Provider::Live.new('live.com').modifications }

    it 'lowercases emails' do
      subject.should include(:lowercase)
    end

    it 'does not remove dots' do
      subject.should_not include(:remove_dots)
    end

    it 'removes plus parts' do
      subject.should include(:remove_plus_part)
    end
  end

  describe '#same_as?' do
    context 'when comparing a provider of the same type' do
      it 'returns true' do
        subject.same_as?(Normailize::Provider::Live.new('live.com')).should be_true
      end
    end

    context 'when comparing a generic provider' do
      it 'returns false' do
        subject.same_as?(Normailize::Provider::Generic.new('somewhere.com')).should be_false
      end
    end

    context 'when comparing a Hotmail provider' do
      it 'returns false' do
        subject.same_as?(Normailize::Provider::Hotmail.new('hotmail.com')).should be_false
      end
    end
  end
end
