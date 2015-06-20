module Sortify
  def sort_option(name, body)
    @sort_options ||= []
    name = name.to_sym 
    
    begin
      scope name, body
    rescue ArgumentError => e
      raise e
    else
      @sort_options << name
    end
  end
  
  def default_sort_option(name)
    @default_sort_option = name.to_sym
  end
  
  def sort_options
    return @sort_options
  end

  def sortify(sort_option = "")
    sort_option = sort_option.to_sym unless sort_option == nil
    
    if @sort_options.include? sort_option
      self.send(sort_option)
    elsif sort_option.empty?
      begin
        self.send(@default_sort_option)
      rescue
        raise NoMethodError, "The default sort option you provided, '#{@default_sort_option.to_s}', does not exist."
      end
    else
      raise NoMethodError, "The sort option you provided, '#{sort_option}', does not exist."
    end
  end
end
