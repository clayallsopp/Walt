module Walt
  module Support
    module_function

=begin
  Constant.for("UIViewAnimationOption", value)
=end

    def constant(base, value)
      return value if value.is_a? Numeric
      value = value.to_s.camelize
      Kernel.const_get("#{base}#{value}")
    end

    private
    def hack
      [
        UIViewAnimationOptionLayoutSubviews,
        UIViewAnimationOptionAllowUserInteraction,
        UIViewAnimationOptionBeginFromCurrentState,
        UIViewAnimationOptionRepeat,
        UIViewAnimationOptionAutoreverse,
        UIViewAnimationOptionOverrideInheritedDuration,
        UIViewAnimationOptionOverrideInheritedCurve,
        UIViewAnimationOptionAllowAnimatedContent,
        UIViewAnimationOptionShowHideTransitionViews,
        UIViewAnimationOptionCurveEaseInOut,
        UIViewAnimationOptionCurveEaseIn,
        UIViewAnimationOptionCurveEaseOut,
        UIViewAnimationOptionCurveLinear,
        UIViewAnimationOptionTransitionNone,
        UIViewAnimationOptionTransitionFlipFromLeft,
        UIViewAnimationOptionTransitionFlipFromRight,
        UIViewAnimationOptionTransitionCurlUp,
        UIViewAnimationOptionTransitionCurlDown,
        UIViewAnimationOptionTransitionCrossDissolve,
        UIViewAnimationOptionTransitionFlipFromTop,
        UIViewAnimationOptionTransitionFlipFromBottom,

        UIViewContentModeScaleToFill,
        UIViewContentModeScaleAspectFit,
        UIViewContentModeScaleAspectFill,
        UIViewContentModeRedraw,
        UIViewContentModeCenter,
        UIViewContentModeTop,
        UIViewContentModeBottom,
        UIViewContentModeLeft,
        UIViewContentModeRight,
        UIViewContentModeTopLeft,
        UIViewContentModeTopRight,
        UIViewContentModeBottomLeft,
        UIViewContentModeBottomRight,

        UITextAlignmentLeft,
        UITextAlignmentRight,
        UITextAlignmentCenter
      ]
    end
  end
end