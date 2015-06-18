require 'spec_helper'

describe Normailize::EmailAddress do
  let(:address) { Normailize::EmailAddress.new('sneaky.dude+lol@gmail.com') }

  describe '#initialize' do
    it 'accepts an email address as argument' do
      expect do
        Normailize::EmailAddress.new('john@doe.com')
      end.to_not raise_error
    end

    context 'when email address is not valid' do
      it 'raises an exception' do
        expect do
          Normailize::EmailAddress.new('not an @email address. sorry!')
        end.to raise_error(ArgumentError)
      end
    end

    context 'when email address is technically valid, but we do not accept it' do
      it 'raises an exception' do
        expect do
          Normailize::EmailAddress.new('" fairly.@.unusual.example.com"(&a_comment_making_it_extralong!)@[IPv6:2001:db8:23:::42]')
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe '#normalized_address' do
    it 'returns expected normalized address' do
      emails = {
        'rahenadibirfx+seicascoumsip@gmail.com'             => 'rahenadibirfx@gmail.com',
        'ScrapeBoxAutoa.pp.r.ovelist+427727@googlemail.com' => 'scrapeboxautoapprovelist@googlemail.com',
        'scrapeboxautoa.pp.r..ovelist+427727@gmail.com'     => 'scrapeboxautoapprovelist@gmail.com',
        'o.b.r.a.c.h.t.p.r.d.z.y.n.s.k.i+22@gmail.com'      => 'obrachtprdzynski@gmail.com',
        'z+o.e+j+ayl.e+em+a+r.t+i.n+d3u76n@gmail.com'       => 'z@gmail.com',
        'sneakydude+lol@live.com'                           => 'sneakydude@live.com',
        'alias-001@yahoo.com'                               => 'alias@yahoo.com',
      }

      emails.each_pair do |sneaky, expected_normalization|
        Normailize::EmailAddress.new(sneaky).normalized_address.should == expected_normalization
      end
    end
  end

  describe '#provider' do
    context 'when address is a @gmail.com' do
      it 'returns instance of Gmail provider' do
        Normailize::EmailAddress.new('john@gmail.com').provider.should be_a(Normailize::Provider::Gmail)
      end
    end

    context 'when address is a @googlemail.com' do
      it 'returns instance of Gmail provider' do
        Normailize::EmailAddress.new('john@googlemail.com').provider.should be_a(Normailize::Provider::Gmail)
      end
    end

    context 'when address is a @yahoo.com' do
      it 'returns instance of Yahoo provider' do
        Normailize::EmailAddress.new('john@yahoo.com').provider.should be_a(Normailize::Provider::Yahoo)
      end
    end

    context 'when address is a @yahoo.co.id' do
      it 'returns instance of Yahoo provider' do
        Normailize::EmailAddress.new('john@yahoo.co.id').provider.should be_a(Normailize::Provider::Yahoo)
      end
    end

    context 'when address is an unknown provider' do
      it 'returns instance of Generic provider' do
        Normailize::EmailAddress.new('john@somewhere.com').provider.should be_a(Normailize::Provider::Generic)
      end
    end
  end

  describe '#same_as?' do
    context 'when emails are the same' do 
      it 'returns true' do
        emails = {
          'john@gmail.com'           => 'john@gmail.com',
          'john+lol@gmail.com'       => 'john+wtf@gmail.com',
          'JoHn@gmail.com'           => 'jOhN@gmail.com',
          'jo.hn@gmail.com'          => 'j.oh.n@gmail.com',
          'Jo.h.n+lol+wtf@gmail.com' => 'jO.h.n+lol@googlemail.com',
          'john@live.com'            => 'john@live.com',
          'JoHn@live.com'            => 'jOhN@live.com',
          'john+lol@live.com'        => 'john+wtf@live.com',
          'John+lol+wtf@live.com'    => 'jOhn+lol@live.com',
          'john@hotmail.com'         => 'john@hotmail.com',
          'john-john@yahoo.com'      => 'john-wtf@yahoo.com',
        }

        emails.each_pair do |e1, e2|
          Normailize::EmailAddress.new(e1).same_as?(Normailize::EmailAddress.new(e2)).should be_true
        end
      end
    end

    context 'when emails are not the same' do
      it 'returns false' do
        emails = {
          'john@gmail.com'      => 'john@live.com',
          'johnny@gmail.com'    => 'john@gmail.com',
          'john@googlemail.com' => 'john@hotmail.com',
          'john+lol@gmail.com'  => 'john+lol@live.com',
        }

        emails.each_pair do |e1, e2|
          Normailize::EmailAddress.new(e1).same_as?(Normailize::EmailAddress.new(e2)).should be_false
        end
      end
    end
  end
end
