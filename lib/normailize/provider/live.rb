module Normailize
  module Provider

    # Internal: A provider to represent Live
    class Live
      include Normailize::Provider
      
      # A Live account only works on the live.com domain
      set_domains 'live.com'

      # A mormalized Live address is lowercased and everything after a plus sign is removed 
      set_modifications :lowercase, :remove_plus_part
    end
  end
end
