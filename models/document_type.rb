class DocumentType
  include Seedable
  seedable_from :folio, fallbacks: true

  REJECT = ["CA Privacy Notice", "WI Spousal Notification"].freeze

  def self.all
    super.sort.reject { |type| REJECT.include? type }
  end
end
