=begin
  {
    text: "This goes on the screen",
    text_color: "ff0000",
    background_color: "00ff00",
    number_of_lines: 2,
    text_alignment: :center,
    font: "MarkerFelt" # see support/font.rb
    attributes: {...} # see support/font.rb
  }
=end
module Walt
  class TextAsset < Asset
    PROPERTIES = [:text, :text_color, :background_color, :number_of_lines, :font, :attributes, :text_alignment]
    attr_accessor *PROPERTIES

    attr_default :content_mode, [UIViewContentModeRedraw]
    attr_default :text_color, UIColor.blackColor
    attr_default :background_color, UIColor.clearColor
    attr_default :number_of_lines, 1

    def initialize(params = {})
      super

      params.is_a?(NSDictionary) && params.each do |key, value|
        if PROPERTIES.include?(key.to_sym)
          self.send("#{key}=", value)
        end
      end
    end

    def view
      @view ||= UILabel.alloc.initWithFrame(CGRectZero).tap do |view|
        view.frame = [self.position || CGPointZero, self.size || CGSizeZero]
        view.contentMode = self.view_content_mode
        view.clipsToBounds = self.clips_to_bounds
        view.text = self.text
        view.textColor = self.text_color.to_color
        view.backgroundColor = self.background_color.to_color
        view.numberOfLines = self.number_of_lines
        view.font = Walt::Font.make(self.font) if self.font
        view.textAlignment = Walt::Support.constant("UITextAlignment", self.text_alignment) if self.text_alignment

        if self.attributes
          attributes = Walt::Font.attributes(self.attributes)
          view.font = attributes[UITextAttributeFont] if attributes[UITextAttributeFont]
          view.textColor = attributes[UITextAttributeTextColor] if attributes[UITextAttributeTextColor]
          view.shadowColor = attributes[UITextAttributeTextShadowColor] if attributes[UITextAttributeTextShadowColor]
          if attributes[UITextAttributeTextShadowOffset]
            view.shadowOffset = CGSizeMake(self.attributes[:shadow_offset][:x], self.attributes[:shadow_offset][:y])
          end
        end

        if !self.size
          view.sizeToFit
        end

        Dispatch::Queue.main.async do
          self.on_ready(true)
        end
      end
    end
  end
end