#Sortify
[![Build Status](https://travis-ci.org/meltheadorable/sortify.svg)](https://travis-ci.org/meltheadorable/sortify)
[![Code Climate](https://codeclimate.com/github/meltheadorable/sortify/badges/gpa.svg)](https://codeclimate.com/github/meltheadorable/sortify)
[![Coverage Status](https://coveralls.io/repos/meltheadorable/sortify/badge.svg)](https://coveralls.io/r/meltheadorable/sortify)

Sortify helps you handle user-provided sort options in Rails apps.

> #### :warning: **Warning**:
> Sortify is in the very early stages of development right now, has no tests and could introduce breaking changes. Use at your own risk.

## Getting Started

To get started, add sortify to your gemfile:

`gem 'sortify', github: 'meltheadorable/github', branch: 'develop'`

You can then run `bundle install` to fetch the current development version.

## Usage

Using Sortify is very simple. All you need to do is specify sorting options in your models, then call `sortify` in your controllers naming a sorting option.

### Models

Sortify acts as a wrapper around ActiveRecord scopes, providing a tiny bit of extra functionality to keep track of valid sorting options.

If you don't know what scopes are, [you can read about them here](http://guides.rubyonrails.org/active_record_querying.html#scopes):

First you'll need to extend Sortify, and then you can specify your sort options.

```ruby
class Item < ActiveRecord::Base
  extend Sortify # includes the sortify methods in your model

  default_sort_option :most_recent
  sort_option :most_recent, -> { order(updated_at: :desc) }
  sort_option :created_first, -> { order(created_at: :asc) }
end
```

`sort_option` takes a symbol as a name, and a lambda, exactly like an ActiveRecord scope.

You can optionally provide a `default_sort_option` which specifies which sort to use in the event that the user-specified sort is invalid or absent.


### Controllers

For your controllers, Sortify provides the `sortify` method, which takes a string naming one of your sort options as an argument. Because Sortify uses scopes under the hood, it can be chained with other scopes.

> #### :warning: **Warning**:
> The `sortify` method will raise a `NoMethodError` if it cannot find a sorting option with the name you passed in unless a valid default is specified.

```ruby
class ItemController < ApplicationController
  def index
    @items = Item.sortify("most_recent") # sorts your items by most recent
    @others = Item.sortify(params[:sort]) # sorts by the method specified in the params
  end
end
```

Because it uses scopes under the hood, Sortify also provides separate methods for your sorting options:

```ruby
class ItemController < ApplicationController
  def index
    @items = Item.created_first # all of your Items, sorted by creation date
  end
end
```

## License

Sortify is released under the [MIT License](LICENSE)
