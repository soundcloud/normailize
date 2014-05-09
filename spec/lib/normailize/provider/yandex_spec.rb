require 'spec_helper'

describe Normailize::Provider::Yandex do
  subject { Normailize::Provider::Yandex.new('yandex.ru') }

  it 'includes the Provider module' do
    subject.should be_a(Normailize::Provider)
  end

  it 'is not a generic provider' do
    subject.should_not be_generic
  end

  describe '.domains' do
    subject { Normailize::Provider::Yandex.domains }

    %w(yandex.ru yandex.com yandex.ua yandex.kz yandex.by ya.ru).each do |domain|
      it 'includes #{domain}' do
        subject.should include(domain)
      end
    end
  end

  describe '#modifications' do
    subject { Normailize::Provider::Yandex.new('yandex.ru').modifications }

    it 'lowercases emails' do
      subject.should include(:lowercase)
    end

    it 'removes plus parts' do
      subject.should include(:remove_plus_part)
    end

    it 'replaces dashes with dots parts' do
      subject.should include(:replace_dashes_with_dots)
    end
  end

  describe '#same_as?' do
    context 'when comparing a provider of the same type' do
      it 'returns true' do
        subject.same_as?(Normailize::Provider::Yandex.new('yandex.ru')).should be_true
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
