module RemoteRecord
  module Query
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def find(id)
        found = remote.find(id)
        found ? new(found) : nil
      end

      def find_by(attrs)
        found = remote.where(attrs).first
        found ? new(found) : nil
      end

      # deprecated
      def find_by_link(link)
        return nil unless link.include?(table_name) &&
          (matches = link.match(/#{table_name}\/(\d)/))
        id = matches.captures.first
        find(id)
      end

      def where(attrs)
        collection = remote.where(attrs).fetch
        collection.map { |object| new(object) }
      end

      def table_name
        to_s.underscore.pluralize
      end
    end
  end
end
