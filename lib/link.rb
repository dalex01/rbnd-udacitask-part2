class LinkItem
  include Listable
  attr_reader :description, :type, :site_name

  def initialize(url, type, options={})
    @description = url
    @site_name = options[:site_name]
    @type = type
  end

  def details
    format_description(@description) +
    format_type(@type) +
    "site name: " + format_name(@site_name)
  end
end
