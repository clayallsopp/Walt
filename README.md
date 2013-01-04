# Walt

Make this:

![Walt animation](http://i.imgur.com/yd4RJ.gif)

Using this:

```ruby
@view = UIView.alloc.initWithFrame(....)

Walt.animate(
  assets: [{
    id: "logo",
    position: [100, 0],
    size: [110, 40],
    url: "http://bit.ly/S98Ta5"
  }],
  animations: [{
    duration: 2,
    operations: [{
      move: "logo",
      to: 150,
      axis: :y
    }],
    after: {
      duration: 2,
      operations: [{
        rotate: "logo",
        to: 360
      }]
    }
  }],
  in: @view
)
```

## Installation

First install the `Walt` gem:

`gem install walt`

Add `Walt` to your Gemfile or require it in your `Rakefile`:

```ruby
require 'walt'
```

```ruby
gem 'walt'
```

Finally, add [AFNetworking](https://github.com/AFNetworking/AFNetworking) to your `pods`:

```ruby
app.pods do
  pod "AFNetworking"
end
```

## Usage

Walt is organized around `assets`, `animations`, and `operations`. Each `animation` is a collection of `operations` occuring at the same time and configuration. 

### Assets

Walt supports arbitrary `UIView`s as assets, and can also build some types of views from hashes. Constructor hashes include:

```ruby
# Uses an existing `UIView`
{ id: "my_id", view: UIView.alloc.initWithFrame(...) }

# Creates a new `UIView`
# All Walt::Assets support these options:
# :position, :size, :view, :content_mode, :clips_to_bounds, :background_color
{ id: "my_id", size: [100,100], background_color: "0088cc" }

# Creates a new `UILabel`; also supports:
# :text_color, :background_color, :number_of_lines, :font, :text_alignment
{ id: "my_id", text: "Hello World" }

# Creates a new `UIImageView`
{ id: "my_id", url: "http://imgur.com/hello.png" }

```

### Operations

Walt comes with a few nifty operations, and adding your own is easy.

#### `Move`

```ruby
  {
    move: "my_id",
    from: [10, 10],
    to: [50, 50]
  }
```

```ruby
  {
    move: "my_id",
    from: 0,
    to: 100,
    axis: :y # also supports :x
  }
```

#### `Rotate`

```ruby
  {
    fade: "my_id",
    from: 20, # in degrees
    to: 50
  }
```

#### `Fade`

```ruby
  {
    fade: "my_id",
    from: 1.0,
    to: 0.2
  }
```

#### Adding your own

Create a subclass of `Walt::Operation::Base` with a name of the form `____Operation` (i.e. `FancyOperation`). In your class, implement `def setup(view, animation)` and `def finalize(view, animation)`. Then, you can use a hash of the form `{fancy: "my_id"}` to use that operation.

Example:

```ruby
module Walt
  module Operation
    class FancyOperation < Base

    def setup(view, animation)
      ...
    end

    def finalize(view, animation)
      ...
    end
  end
end

Walt.animate(...
  {
    fancy: "my_id"
  }
)
```


### Animations

Animations control the timing and configuration of operations. They support `:delay` and `:duration` settings which affect timing, and a `:options` setting which you can pass a list of `UIViewAnimationOption`s for that animation.

Animations can be chained using an animation's `:after` property, which takes another animation hash.

```ruby
# Also applies to Walt.animate
{
  delay: 0.3,
  duration: 2.2,
  options: [:curve_ease_in, :begin_from_current_state],
  operations: [...],
  after: {
    delay: 1.0,
    duration: 1.0,
    ...
  }
}
```
