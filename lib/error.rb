module RemoteRecord
  class SourceNotImplementedError < StandardError
    def initialize(klass)
      @klass = klass
    end

    def message
      "Source not implemented for class #{@klass}"
    end
  end
end
