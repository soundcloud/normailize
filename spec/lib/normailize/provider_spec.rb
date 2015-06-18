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

    context 'when given yahoo.com as domain' do
      it 'returns the Yahoo provider' do
        Normailize::Provider.factory('yahoo.com').should be_a(Normailize::Provider::Yahoo)
      end
    end

    context 'when given yahoo.co.id as domain' do
      it 'returns the Yahoo provider' do
        Normailize::Provider.factory('yahoo.co.id').should be_a(Normailize::Provider::Yahoo)
      end
    end

    context 'when given an unknown domain' do
      it 'returns instance of Generic provider' do
        Normailize::Provider.factory('somewhere.com').should be_a(Normailize::Provider::Generic)
      end
    end
  end
end
