class TodoItem
  include Listable
  attr_reader :description, :type, :due, :priority

  def initialize(description, type, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @type = type
  end

  def details
    format_description(@description) +
    format_type(@type) +
    "due: " + format_date({:due => @due}) +
    format_priority(@priority)
  end
end
