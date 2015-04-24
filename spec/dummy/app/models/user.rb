class User < ActiveRecord::Base
  extend Sortify
  
  sort_option :alphabetical, -> { order(username: :asc) }
end
