require 'remote_record/error'

module RemoteRecord
  class Base
    include Conversion
    include Delegation
    include Persistence
    include Query

    attr_reader :instance
    delegate :response_errors, :persisted?

    def self.source(service, class_name: self.name, delegate_attributes: true)
      service = service.to_s.camelize.constantize
      @remote = service.const_get(class_name)
      @attributes_delegated = delegate_attributes
    end

    def self.remote
      @remote || raise(SourceNotImplementedError.new(to_s))
    end

    def remote
      self.class.remote
    end

    def self.attributes_delegated?
      @attributes_delegated
    end

    def attributes_delegated?
      self.class.attributes_delegated?
    end

    def initialize(instance_or_attrs={})
      if instance_or_attrs.is_a?(remote)
        @instance = instance_or_attrs
      else
        @instance = remote.new(instance_or_attrs)
      end
    end
  end
end
