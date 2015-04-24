require 'active_record'
require 'sortify'

class WithSortify < ActiveRecord::Base
  extend Sortify
  
  sort_option :recent, -> { order(created_at: :desc) }
end

describe Sortify do
  context "sort_options" do
    it "returns a list of sort options" do
      expect(WithSortify.sort_options).to eq [:recent]
    end
  end
end