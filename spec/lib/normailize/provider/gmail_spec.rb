require 'spec_helper'

describe Normailize::Provider::Gmail do
  subject { Normailize::Provider::Gmail.new('gmail.com') }

  it 'includes the Provider module' do
    subject.should be_a(Normailize::Provider)
  end

  it 'is not a generic provider' do
    subject.should_not be_generic
  end

  describe '.domains' do
    subject { Normailize::Provider::Gmail.domains }

    it 'includes gmail.com' do
      subject.should include('gmail.com')
    end

    it 'includes googlemail.com' do
      subject.should include('googlemail.com')
    end
  end

  describe '#modifications' do
    subject { Normailize::Provider::Gmail.new('gmail.com').modifications }

    it 'lowercases emails' do
      subject.should include(:lowercase)
    end

    it 'removes dots' do
      subject.should include(:remove_dots)
    end

    it 'removes plus parts' do
      subject.should include(:remove_plus_part)
    end
  end

  describe '#same_as?' do
    context 'when comparing a provider of the same type' do
      it 'returns true' do
        subject.same_as?(Normailize::Provider::Gmail.new('gmail.com')).should be_true
      end
    end

    context 'when comparing a generic provider' do
      it 'returns false' do
        subject.same_as?(Normailize::Provider::Generic.new('somewhere.com')).should be_false
      end
    end
  end
end
