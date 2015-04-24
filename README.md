#Sortify

Sortify was grown out of a need to have a clean, safe, and simple way to allow user-supplied sorting options in rails.

> :warning: Sortify is in the very early stages of development right now, has no tests and could introduce breaking changes. Use at your own risk.

## Getting Started

To get started, add sortify to your gemfile:

`gem 'sortify', github: 'meltheadorable/github'`

You can then run `bundle install` to fetch the current development version.

## Usage

Using Sortify is very simple, and only requires a little bit of code in your models and controllers.



### Models

Sortify acts as a wrapper around ActiveRecord scopes, providing a tiny bit of extra functionality to keep track of valid sorting options.

If you don't know what scopes are, [you can read about them here](http://guides.rubyonrails.org/active_record_querying.html#scopes):

First you'll need to extend Sortify, and then you can specify your sort options.

```ruby
class Item < ActiveRecord::Base
  extend Sortify # includes the sortify methods in your model

  sort_option :most_recent, -> { order(updated_at: :desc) }
  sort_option :created_first, -> { order(created_at: :asc) }
end
```

`sort_option` takes a symbol as a name, and a lambda, exactly like an ActiveRecord scope.


### Controllers

For your controllers, Sortify provides the `sortify` method, which takes a string naming one of your sort options as an argument. Because Sortify uses scopes under the hood, it can be chained with other scopes.

> :warning: The `sortify` method will raise a `NoMethodError` if it cannot find a sorting option with the name you passed in. An option to specify a default sorting method is under development.

```ruby
class ItemController < ApplicationController
  def index
    @items = Item.sortify("most_recent") # sorts all of your items by most recent
    @other_items = Item.sortify(params[:sort]) # sorts items by the method specified by the user in the parameters
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
