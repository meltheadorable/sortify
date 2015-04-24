class Product < ActiveRecord::Base
  extend Sortify
  
  sort_option :most_recent, -> { order(created_at: :desc) }
  sort_option :destroy, -> { order(created_at: :asc) }
end
