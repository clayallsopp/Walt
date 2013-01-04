=begin
  {
    from: {
      x: 0, y: 0
    },
    to: {
      x: 10, y: 20
    }
  }
=end

module Walt
  module Operation
    class MoveOperation < Base
      PROPERTIES = [:from, :to, :axis]
      attr_accessor *PROPERTIES

      attr_default :axis, :x

      def initialize(params = {})
        super

        if axis = (params[:axis] || params["axis"])
          self.axis = axis
        end

        params.each do |key, value|
          if PROPERTIES.include?(key.to_sym)
            self.send("#{key}=", value)
          end
        end
      end

      ["from", "to"].each do |point|
        define_method("#{point}=") do |new_point|
          _point = new_point
          case new_point
          when Numeric
            if self.axis.to_sym == :x
              _point = [new_point, nil]
            else
              _point = [nil, new_point]
            end
          when CGPoint
            _point = [new_point.x, new_point.y]
          when NSArray
          else
            raise "Invalid class for #{point}=: #{new_point.inspect}"
          end
          instance_variable_set("@#{point}", _point)
        end
      end

      def setup(view, animation)
        if self.from
          origin = view.frame.origin
          origin.x = (self.from[0] || origin.x) 
          origin.y = (self.from[1] || origin.y)
          view.frame = [origin, view.frame.size]
        end
      end

      def finalize(view, animation)
        origin = view.frame.origin
        origin.x = (self.to[0] || origin.x) 
        origin.y = (self.to[1] || origin.y)
        view.frame = [origin, view.frame.size]
      end
    end
  end
end