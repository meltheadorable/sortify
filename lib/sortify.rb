module Sortify
  def sort_option(name, lambda = -> {} )
    @sort_options ||= []
    name = name.to_sym
    
    begin
      scope name, lambda
    rescue ArgumentError => e
      raise e
    else
      @sort_options << name
    end
  end
  
  def sort_options
    return @sort_options
  end

  def sortify(sort_option)
    sort_option = sort_option.to_sym
    
    if @sort_options.include? sort_option
      self.send(sort_option)
    else
      raise NoMethodError
    end
  end
end
