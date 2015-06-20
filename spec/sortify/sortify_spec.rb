require 'active_record'
require 'sortify'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define do
  create_table :sortable_items, force: true do |t|
    t.string :name
    t.datetime "created_at",  null: false
  end
end

class SortableItem < ActiveRecord::Base
  extend Sortify
  
  default_sort_option :alphabetical
  sort_option :alphabetical, -> { order(name: :asc) }
  sort_option :recent, -> { order(created_at: :desc) }
end

class ItemWithBadDefault < ActiveRecord::Base
  extend Sortify
  
  default_sort_option :nothing_here
  sort_option :something_here, -> { order(:created_at) }
end

describe Sortify do
  it "should return a list of sort options" do
    expect(SortableItem.sort_options).to eq [:alphabetical, :recent]
  end
  
  it "should raise an error when the sorting option doesn't exist" do
    expect{ SortableItem.sortify("fake_option") }.to raise_error "The sort option you provided, 'fake_option', does not exist."
  end
  
  it "should raise an error when default sort does not exist" do
    expect{ ItemWithBadDefault.sortify }.to raise_error "The default sort option you provided, 'nothing_here', does not exist."
  end
  
  context "sorting methods" do
    before(:each) do
      @item1 = SortableItem.create(name: "First Item")
      @item2 = SortableItem.create(name: "Second Item")
      @item3 = SortableItem.create(name: "Last Item")  
    end
    
    after(:each) do
      SortableItem.destroy_all
    end
    
    it "should return sorted list of items" do
      @sorted = SortableItem.sortify("recent")
      expect(@sorted.map(&:name)).to eq ["Last Item", "Second Item", "First Item"]
    end
    
    it "should return a sorted list when a default is specified" do
      @sorted = SortableItem.sortify
      expect(@sorted.map(&:name)).to eq [ "First Item", "Last Item", "Second Item"]
    end
  end
  
end