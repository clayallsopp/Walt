=begin
  {
    id: :one,
    size: [100,100],
    position: [10, 10],
    # array of integers or symbols corresponding to UIViewContentMode
    content_mode: [:scale_to_fill, :top],
    clips_to_bounds: true,
    background_color: "0088ff"
  }
=end

module Walt
  class Asset
    extend Walt::Support::AttrDefault

    PROPERTIES = [:id, :position, :size, :view, :content_mode, :clips_to_bounds, :background_color]
    attr_accessor *PROPERTIES

    def self.for(params = {})
      if params.is_a?(NSDictionary) && params[:url]
        Walt::ImageAsset.new(params)
      elsif params.is_a?(NSDictionary) && params[:text]
        Walt::TextAsset.new(params)
      else
        self.new(params)
      end
    end

    def initialize(params = {})
      case params
      when UIView
        self.view = params
      when NSDictionary
        params.each do |key, value|
          if PROPERTIES.include?(key.to_sym)
            self.send("#{key}=", value)
          end
        end
      end
    end

    attr_default :clips_to_bounds, false

    attr_default :content_mode, [UIViewContentModeScaleToFill]
    def content_mode=(content_mode)
      _content_mode = content_mode.is_a?(NSArray) ? content_mode : [content_mode]
      @content_mode = _content_mode
    end

    def view_content_mode
      int = 0
      self.content_mode.each { |i| int = int | Walt::Support.constant("UIViewContentMode", i)}
      int
    end

    def view
      @view ||= UIView.alloc.initWithFrame(CGRectZero).tap do |view|
        view.frame = [self.position || CGPointZero, self.size || CGSizeZero]
        view.backgroundColor = self.background_color.to_color if self.background_color
        view.contentMode = self.view_content_mode
        view.clipsToBounds = self.clips_to_bounds
        Dispatch::Queue.main.async do
          self.on_ready(true)
        end
      end
    end

    def on_ready(trigger = false, &callback)
      @on_ready_callbacks ||= []
      if callback
        @on_ready_callbacks << callback
      elsif trigger
        @on_ready_callbacks.each {|c| c.call(self)}
        @on_ready_callbacks = []
      end
    end
  end
end