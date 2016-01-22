module RemoteRecord
  module Delegation
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def delegate(*methods, to: :@instance, &block)
        super
      end
    end

    def method_missing(method, *args, &block)
      if attributes_delegated? && instance.attributes.include?(method)
        instance.send(method, *args, &block)
      else
        super
      end
    end
  end
end
