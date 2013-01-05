=begin
  {
    delay: 0.5,
    duration: 2.5,
    # array of integers or symbols corresponding to UIViewAnimationOptions
    options: [:curve_ease_in, :autoreverse]
    operations: [{
      # see operation/base.rb
      type: :move,
      from: 0,
      to: 40,
      id: :one
    }],
    after: {
      # another animation object
    }
  }
=end

module Walt
  class Animation
    extend Walt::Support::AttrDefault

    PROPERTIES = [:delay, :duration, :after, :operations, :options]
    attr_accessor *PROPERTIES

    def initialize(params = {})
      params.each do |key, value|
        if PROPERTIES.include?(key.to_sym)
          self.send("#{key}=", value)
        end
      end
    end

    def after=(after)
      _after = after
      case after
      when Walt::Animation
      when NSDictionary
        _after = Walt::Animation.new(after)
      else
        raise "Invalid class for after animation #{after.inspect}"
      end

      @after = _after
    end

    attr_default :operations, []
    def operations=(operations)
      _operations = []
      operations.each do |op|
        case op
        when Walt::Operation::Base
          _operations << op
        when NSDictionary
          _operations << Walt::Operation.for(op)
        else
          raise "Invalid class for operation #{op.inspect}"
        end
      end
      @operations = _operations
    end

    attr_default :assets, {}
    def assets=(assets)
      _assets = {}
      case assets
      when NSArray
        assets.each do |asset|
          _asset = (asset.is_a?(Walt::Asset) ? asset : Walt::Asset.for(asset))
          _assets[_asset.id] = _asset
        end
      when NSDictionary
        assets.each do |key, value|
          asset = value
          _asset = (asset.is_a?(Walt::Asset) ? asset : Walt::Asset.for(asset))
          _assets[_asset.id] = _asset
        end
      else
        raise "Not a valid class for assets: #{assets.inspect}"
      end
      @assets = _assets
    end

    attr_default :options, [UIViewAnimationOptionCurveEaseInOut]
    def options=(options)
      _options = options.is_a?(NSArray) ? options : [options]
      @options = _options
    end

    def animation_options
      int = 0
      self.options.each { |i| int = int | Walt::Support.constant("UIViewAnimationOption", i)}
      int
    end

    def animate
      @operations_completed = 0
      self.operations.each do |operation|
        asset = self.assets[operation.id]
        if !asset
          raise "No asset found for operation #{operation} id #{operation.id}"
        end

        operation.setup(asset.view, self)

        UIView.animateWithDuration(self.duration,
          delay:self.delay.to_f,
          options:self.animation_options,
          animations:lambda {
            operation.finalize(asset.view, self)
          },
          completion:lambda { |completed|
            @operations_completed += 1
            if @operations_completed == self.operations.count && self.after
              self.after.assets = self.assets
              self.after.animate
            end
          }
        )
      end
    end
  end
end