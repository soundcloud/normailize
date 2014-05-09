module Normailize
  module Provider

    # Internal: A provider to represent Yandex domains
    class Yandex
      include Normailize::Provider

      # Yandex addresses work on several different domains
      set_domains *%w(yandex.ru yandex.com yandex.ua yandex.kz yandex.by ya.ru)

      # A normalized Yandex address is lowercased, everything after a
      # plus sign is removed from the username part and all dashes replaced with dots
      set_modifications :lowercase, :remove_plus_part, :replace_dashes_with_dots
    end
  end
end
