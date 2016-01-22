module RemoteRecord
  module Persistence
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def create(attrs)
        new(remote.create(attrs))
      end

      def post_raw(url)
        remote.post_raw(url)
      end
    end

    def save
      saved = instance.save
      saved ? self : false
    end

    def update(attrs)
      attrs.each do |attr, value|
        instance.send("#{attr}=", value)
      end
      save
    end
  end
end
