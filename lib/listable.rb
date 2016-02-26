module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(options={})
  	if (options.has_key?(:due))
  		due = options[:due]
  		due ? due.strftime("%D") : "No due date"
  	elsif (options.has_key?(:start_date) || options.has_key?(:end_date))
  		start_date = options[:start_date]
  		end_date = options[:end_date]
  		dates = start_date.strftime("%D") if start_date
	    dates << " -- " + end_date.strftime("%D") if end_date
	    dates = "N/A" if !dates
	    return dates
  	end
  end

  def format_priority(priority)
    value = " ⇩".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:green) if priority == "medium"
    value = " ⇩".colorize(:blue) if priority == "low"
    value = "" if !priority
    return value
  end

  def format_name(site_name)
    site_name ? site_name : ""
  end

end