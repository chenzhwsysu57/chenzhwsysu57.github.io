# Jekyll 3.9/Liquid 4 still calls Ruby's removed taint APIs.
# Keep the legacy methods available so the site can be built with Ruby 4.
unless Object.method_defined?(:tainted?)
  class Object
    def tainted?
      false
    end

    def taint
      self
    end

    def untaint
      self
    end

    def untrusted?
      false
    end

    def trust
      self
    end

    def untrust
      self
    end
  end
end
