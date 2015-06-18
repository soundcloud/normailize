module Normailize
  module Provider

    # Internal: A provider to represent Yahoo! Mail
    class Yahoo
      include Normailize::Provider

      # Includes only domains usable by ID users
      set_domains 'yahoo.com', 'yahoo.co.id'

      # Remove the dash part that only exists in disposable address.
      # Note that Yahoo! Mail doesn't support plus-addressing.
      set_modifications :lowercase, :remove_dash_part
    end
  end
end
