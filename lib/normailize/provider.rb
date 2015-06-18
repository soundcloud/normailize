module Normailize

  # Public: Module to give email provider classes default functionality
  module Provider

    # Internal: Create a provider instance from a domain
    #
    # domain - A domain for an email provider, like gmail.com
    #
    # Returns an instance of a provider that recognizes the domain or a
    # generic provider
    def self.factory(domain)
      case domain
      when *Gmail.domains   then Gmail.new(domain)
      when *Yahoo.domains   then Yahoo.new(domain)
      else Generic.new(domain)
      end
    end

    def self.included(base)
      class << base; attr_accessor :domains, :modifications end
      base.extend(ClassMethods)    
    end

    module ClassMethods

      # Public: Set on or more domains for a provider
      #
      # *domains - one or more domains
      #
      # Returns nothing
      def set_domains(*domains)
        @domains = domains
      end

      # Public: Set one or more modifications to be performed on email address
      # belonging to the provider
      #
      # *modifications - One or more modification symbols
      #
      # Currently, the following modifications are supported:
      #
      #   - :lowercase         Lowercase characthers in username part
      #   - :remove_dots       Removes all dots in username part
      #   - :remove_plus_part  Removes everything after the first occurrence of a plus sign
      #
      # Returns nothing
      def set_modifications(*modifications)
        self.modifications = modifications.map(&:to_sym)
      end

      # Internal: Get domains that are associated with the provider
      #
      # Returns an array of domains
      def domains
        @domains || []
      end
    end

    # Public: Class initializer
    #
    # domain - A domain like gmail.com
    #
    # Returns nothing
    def initialize(domain)
      @domain = domain
    end

    # Internal: Get all modification rules for the provider
    #
    # Returns symbols that tell the email class how to normalize an address
    # for the provider
    def modifications
      self.class.modifications || []
    end

    # Internal: Get the domain that the provider was instantiated with
    #
    # Returns domain
    def domain
      @domain
    end

    # Internal: Determine if a provider is generic or not
    #
    # Returns true if generic or false if not
    def generic?
      self.is_a?(Normailize::Provider::Generic)
    end

    # Internal: Determine if two providers are the same or not
    #
    # provider - An instance of another provider class
    #
    # Returns true if providers are the same or false if not
    def same_as?(provider)
      if self.generic? || provider.generic?
        @domain == provider.domain
      else
        self.class == provider.class
      end
    end
  end
end
