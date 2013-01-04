=begin
  {
    from: 0,
    to: 1
  }
=end

p "rotate.rb"
module Walt
  module Operation
    class RotateOperation < Base
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
        rotate = CABasicAnimation.animationWithKeyPath("transform.rotation")

        from = self.from || view.instance_variable_get("@__last_rotation") || 0
        rotate.fromValue = NSNumber.numberWithFloat(from)

        rotate.toValue = NSNumber.numberWithFloat(self.to * Math::PI / 180)
        view.instance_variable_set("@__last_rotation", rotate.toValue.to_f)

        rotate.duration = animation.duration
        rotate.removedOnCompletion = false
        rotate.fillMode = KCAFillModeForwards

        view.layer.addAnimation(rotate, forKey:nil)
      end
    end
  end
end