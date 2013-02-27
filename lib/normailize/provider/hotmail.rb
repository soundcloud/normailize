module Normailize
  module Provider

    # Internal: A provider to represent Hotmail
    class Hotmail
      include Normailize::Provider

      # A hotmail account only works on the hotmail.com domain
      set_domains 'hotmail.com'

      # A normalized hotmail address is lowercased and everything after a plus sign is removed
      set_modifications :lowercase, :remove_plus_part
    end
  end
end
