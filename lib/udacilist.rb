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
    @items.push TodoItem.new(description, type, options) if type == "todo"
    @items.push EventItem.new(description, type, options) if type == "event"
    @items.push LinkItem.new(description, type, options) if type == "link"
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize, "Index: " + index.to_s + ", max index: " + (@items.length-1).to_s if @items.length < index
    @items.delete_at(index - 1)
  end

  def all
    table = filter_items @items
    puts table
  end

  def filter(type)
    filtered = []
    if (type == "event")
      filtered = @items.select{|item| item.is_a?(EventItem)}
    elsif (type == "todo")
      filtered = @items.select{|item| item.is_a?(TodoItem)}
    elsif (type == "link")
      filtered = @items.select{|item| item.is_a?(LinkItem)}
    end
    table = filter_items filtered
    puts table
  end

  def filter_items(itemsArray)
    rows = []
    itemsArray.each_with_index do |item, position|
      rows << [position + 1, item.details]
    end
    Terminal::Table.new :rows => rows
  end

  def find_item(index)
    @items[index - 1]
  end
end
