class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    raise UdaciListErrors::InvalidItemType, "Type: " + type if !(["todo", "event", "link"].include? type)
    priority = options[:priority]
    if (priority)
      raise UdaciListErrors::InvalidPriorityValue, "Priority: " + priority if !(["high", "medium", "low"].include? priority)
    end
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize, "Index: " + index.to_s + ", max index: " + (@items.length-1).to_s if @items.length < index
    @items.delete_at(index - 1)
  end

  def all
    #puts "-" * @title.length
    #puts @title
    #puts "-" * @title.length
    rows = []
    @items.each_with_index do |item, position|
      #puts "#{position + 1}) #{item.details}"
      rows << [position + 1, item.details]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end
