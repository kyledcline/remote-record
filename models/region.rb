class Region < RemoteRecord::Base
  source :rulebook

  def self.serviceable_region_titles
    serviceable_regions.map(&:title)
  end

  def self.serviceable_regions
    where(forbidden: false)
  end
  private_class_method :serviceable_regions
end
