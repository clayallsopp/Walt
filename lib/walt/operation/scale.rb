=begin
  {
    from: 1.0,
    to: 1.2
  }
=end

module Walt
  module Operation
    class ScaleOperation < Base
      PROPERTIES = [:from, :to]
      attr_accessor *PROPERTIES

      def initialize(params = {})
        super

        params.each do |key, value|
          if PROPERTIES.include?(key.to_sym)
            self.send("#{key}=", value)
          end
        end
      end

      def finalize(view, animation)
        scale = CABasicAnimation.animationWithKeyPath("transform.scale")

        from = self.from || view.instance_variable_get("@__last_scale") || 1.0
        scale.fromValue = NSNumber.numberWithFloat(from)

        scale.toValue = NSNumber.numberWithFloat(self.to)
        view.instance_variable_set("@__last_scale", scale.toValue.to_f)

        scale.duration = animation.duration
        scale.removedOnCompletion = false
        scale.fillMode = KCAFillModeForwards

        view.layer.addAnimation(scale, forKey:nil)
      end
    end
  end
end