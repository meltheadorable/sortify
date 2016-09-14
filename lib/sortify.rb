require "whitelist_scope"

module Sortify
  include WhitelistScope
  alias sort_option whitelist_scope
  alias sort_options whitelist

  def default_sort_option(name)
    @default_sort_option = name.to_sym
  end

  def sortify(sort_option = "")
    if sort_option.empty?
      begin
        call_whitelisted_scope(@default_sort_option)
      rescue
        raise NoMethodError, "The default sort option you provided, '#{@default_sort_option}', does not exist."
      end
    else
      call_whitelisted_scope(sort_option)
    end
  end
end
