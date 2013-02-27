module Normailize
  module Provider

    # Internal: A provider to represent Gmail and Googlemail
    class Gmail
      include Normailize::Provider
      
      # Gmail addresses work on both gmail.com and googlemail.com
      set_domains 'gmail.com', 'googlemail.com'

      # A normalized Gmail address is lowercased, dots and everything after a 
      # plus sign is removed from the username part
      set_modifications :lowercase, :remove_dots, :remove_plus_part
    end
  end
end
