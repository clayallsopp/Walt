=begin
  {
    # array of assets (see asset/asset.rb) or UIViews
    assets: [{...}],
    # array of animations (see animation.rb)
    animations: [{...}]
  }
=end
module Walt
  class AnimationSet
    extend Walt::Support::AttrDefault
    
    PROPERTIES = [:animations, :assets]
    attr_accessor *PROPERTIES

    def initialize(params = {})
      params.each do |key, value|
        if PROPERTIES.include?(key.to_sym)
          self.send("#{key}=", value)
        end
      end
    end

    attr_default :animations, []
    def animations=(animations)
      _animations = animations && animations.collect do |animation|
        case animation
        when Walt::Animation
          animation
        when NSDictionary
          Walt::Animation.new(animation)
        else
          raise "Invalid class for animation #{animation.inspect}"
        end
      end
      @animations = _animations
    end

    attr_default :assets, []
    def assets=(assets)
      _assets = assets && assets.collect do |asset|
        case asset
        when Walt::Asset
          asset
        when NSDictionary
          Walt::Asset.for(asset)
        else
          raise "Invalid class for asset #{asset.inspect}"
        end
        asset
      end
      @assets = _assets
    end

    def animate
      self.animations.each do |animation|
        animation.assets = self.assets
        animation.animate
      end
    end
  end
end