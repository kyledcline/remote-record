class Document < RemoteRecord::Base
  source :rolodex

  ACCEPTABLE_EXTENSIONS = %w{PDF TIFF TIF BMP GIF JPEG JPG PNG}

  def self.extension(filename)
    filename.split('.').last.upcase
  end

  def self.acceptable_extension?(filename)
    ACCEPTABLE_EXTENSIONS.include?(extension(filename))
  end
end
