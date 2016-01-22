class DocumentRequest < RemoteRecord::Base
  source :folio

  def fulfilled?
    fulfilled_at.present?
  end
end
