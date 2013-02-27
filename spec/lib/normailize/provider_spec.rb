require 'spec_helper'

describe Normailize::Provider do
  describe '.factory' do
    context 'when given gmail.com as domain' do
      it 'returns the Gmail provider' do
        Normailize::Provider.factory('gmail.com').should be_a(Normailize::Provider::Gmail)
      end
    end

    context 'when given googlemail.com as domain' do
      it 'returns the Gmail provider' do
        Normailize::Provider.factory('googlemail.com').should be_a(Normailize::Provider::Gmail)
      end
    end

    context 'when given live.com as domain' do
      it 'returns the Live provider' do
        Normailize::Provider.factory('live.com').should be_a(Normailize::Provider::Live)
      end
    end

    context 'when given hotmail.com as domain' do
      it 'returns the Hotmail provider' do
        Normailize::Provider.factory('hotmail.com').should be_a(Normailize::Provider::Hotmail)
      end
    end

    context 'when given an unknown domain' do
      it 'returns instance of Generic provider' do
        Normailize::Provider.factory('somewhere.com').should be_a(Normailize::Provider::Generic)
      end
    end
  end
end
