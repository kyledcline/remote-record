module RemoteRecord
  module Conversion
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def convert(attribute, converter)
        define_method(attribute) do
          instance.send(attribute).send(converter)
        end
      end
    end
  end
end
