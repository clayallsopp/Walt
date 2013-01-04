=begin
  {
    type: :move,
    id: :one
  }
=end

module Walt
  module Operation
    class Base
      extend Walt::Support::AttrDefault

      PROPERTIES = [:id, :type]
      attr_accessor *PROPERTIES

      def initialize(params = {})
        params.each do |key, value|
          if PROPERTIES.include?(key.to_sym)
            self.send("#{key}=", value)
          end
        end
      end

      def setup(view, animation)
        # do initial before animation
      end

      def finalize(view, animation = nil)
        # do whatever occurs during the animation
      end
    end

    module_function
    def for(hash)
      # Check classes in module for corresponding operation
      type = hash[:type] || hash["type"]

      # Check for the form {operation_type: :id}
      if !type
        type = (hash.keys.map(&:to_s) | self.operation_types)[0]
        hash[:id] = (hash[type] || hash[type.to_sym])
        hash[:type] = type
      end

      if type.is_a?(Symbol) || type.is_a?(String)
        string = "#{type.to_s.downcase}_operation".camelize
        if not const_defined? string
          raise "Invalid Operation value for operation #{hash.inspect}. Create a class called #{string}."
        end
        return Walt::Operation.const_get(string).new(hash)
      end

      self.new(hash)
    end

    def operation_types
      Walt::Operation.constants(false).select { |constant_name| constant_name =~ /Operation$/ }.collect! { |op| op.to_s.gsub("Operation", "").underscore }
    end
  end
end