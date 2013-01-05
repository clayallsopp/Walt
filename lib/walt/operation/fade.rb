=begin
  {
    from: 0.0,
    to: 0.8
  }
=end

module Walt
  module Operation
    class FadeOperation < Base
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

      def setup(view, animation)
        if self.from
          view.alpha = self.from
        end
      end

      def finalize(view, animation)
        view.alpha = self.to
      end
    end
  end
end