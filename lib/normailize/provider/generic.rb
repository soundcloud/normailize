module Normailize
  module Provider

    # Internal: A generic provider to represent an unknown provider
    class Generic
      include Normailize::Provider

      # By default, any address is lowercased and everything after a plus sign is removed
      set_modifications :lowercase, :remove_plus_part
    end
  end
end
