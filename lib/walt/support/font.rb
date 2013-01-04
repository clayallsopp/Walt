module Walt
  module Font
    module_function

    def bold(size)
      Font.make(:bold, size)
    end

    def system(size)
      Font.make(:system, size)
    end

    def italic(size)
      Font.make(:italic, size)
    end

    # Create font with params:
    # String => The name of the font
    # Hash => {
    #   size: Integer,
    #   name: String (see above)
    # }
    def make(params = {}, *args)
      if params.is_a?(UIFont)
        return params
      end

      _font = nil
      if params.is_a?(NSString)
        params = {name: params}
      end
      if args && args[0]
        params.merge!({size: args[0]})
      end
      params[:size] ||= UIFont.systemFontSize
      if [:system, :bold, :italic].member?(params[:name])
        case params[:name]
        when :system
          _font = UIFont.systemFontOfSize(params[:size].to_f)
        when :bold
          _font = UIFont.boldSystemFontOfSize(params[:size].to_f)
        when :italic
          _font = UIFont.italicSystemFontOfSize(params[:size].to_f)
        end
      end

      if !_font
        begin
          _font = UIFont.fontWithName(params[:name], size: params[:size])
        rescue
        end
      end

      if !_font
        raise "Invalid font for parameters: #{params.inspect} args #{args.inspect}"
      end

      _font
    end

    # Create font attributes with keys:
    # {
    #   font: String or Hash (see Font.make),
    #   color: String,
    #   shadow_color: String,
    #   shadow_offset: {
    #     x: Integer,
    #     y: Integer
    #   }
    # }
    def attributes(params = {})
      _attributes = {}

      _attributes[UITextAttributeFont] = Font.make(params[:font]) if params[:font]
      _attributes[UITextAttributeTextColor] = params[:color].to_color if params[:color]
      _attributes[UITextAttributeTextShadowColor] = params[:shadow_color].to_color if params[:shadow_color]
      _attributes[UITextAttributeTextShadowOffset] = begin
        x = params[:shadow_offset][:x]
        y = params[:shadow_offset][:y]
        offset = UIOffsetMake(x,y)
        NSValue.valueWithUIOffset(offset)
      end if params[:shadow_offset]

      _attributes
    end
  end
end