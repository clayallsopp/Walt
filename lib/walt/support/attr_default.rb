module Walt
  module Support
    module AttrDefault
      def attr_default(attribute, default)
        attr_accessor attribute
        define_method(attribute) do
          ivar = "@#{attribute}"
          if !instance_variable_defined?(ivar)
            instance_variable_set(ivar, default)
          end
          instance_variable_get(ivar)
        end
      end
    end
  end
end