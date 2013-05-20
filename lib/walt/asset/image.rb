motion_require "asset"

=begin
  {
    url: "http://mysite.com/pic.jpg"
  }
=end

module Walt
  class ImageAsset < Asset
    PROPERTIES = [:url]
    attr_accessor *PROPERTIES

    def initialize(params = {})
      super

      params.is_a?(NSDictionary) && params.each do |key, value|
        if PROPERTIES.include?(key.to_sym)
          self.send("#{key}=", value)
        end
      end
    end

    def view
      if !@view
        @view = UIImageView.alloc.initWithFrame(CGRectZero)
        @view.frame = [self.position || CGPointZero, self.size || CGSizeZero]
        @view.contentMode = self.view_content_mode
        @view.clipsToBounds = self.clips_to_bounds
        url = NSURL.URLWithString(self.url)
        if !@view.respond_to?("af_imageRequestOperation")
          raise "You need to add the AFNetworking pod for remote images"
        end
        @view.setImageWithURLRequest(NSURLRequest.requestWithURL(url), 
              placeholderImage:nil,
              success: lambda {|request, response, image|
                @view.image = image
                if !self.size
                  @view.sizeToFit
                end
                Dispatch::Queue.main.async do
                  self.on_ready(true)
                end
              },
              failure: lambda {|request, response, error|

              })
        @view
      end
      @view
    end
  end
end