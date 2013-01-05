=begin
  Use Walt.animate(...) to add animations to a given `UIView`.
  Walt.animate({
    assets: [...],
    animations: [...],
    in: a_ui_view
  })
=end
module Walt
  module_function

  def pending_animations
    @pending_animations ||= []
  end

  def animation_sets
    @animation_sets ||= []
  end

  def pending_assets
    @pending_assets ||= {}
  end

  def animate(animation = {})
    view = animation.delete(:in)

    self.pending_animations << animation

    self.pending_assets[animation.object_id] = animation[:assets].count
    animation[:assets].collect! do |asset|
      _asset = (asset.is_a?(Walt::Asset) ? asset : Walt::Asset.for(asset))
      _asset.on_ready do |a|
        self.pending_assets[animation.object_id] -= 1
        if self.pending_assets[animation.object_id] == 0
          self.trigger_animation(animation)
          self.pending_animations.delete(animation)
        end
      end
      view.addSubview(_asset.view)
      _asset.view.hidden = true
      _asset
    end
  end

  def trigger_animation(animation = {})
    animation_set = Walt::AnimationSet.new(animation)
    animation_set.assets.each do |asset|
      asset.view.hidden = false
    end
    self.animation_sets << animation_set
    animation_set.animate
  end
end