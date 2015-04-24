class Product < ActiveRecord::Base
  extend Sortify
  
  default_sort_option :most_recent
  sort_option :most_recent, -> { order(created_at: :desc) }
end
