module ServiceConfig
  class Provider
    def initialize(args)
      @raise_if_nil = args[:raise_if_nil]
      @use_env = args[:use_env]
      yield self
    end

    def provides(name, default_value = '', options = {})
      raise_unset(name) if guarded_against_unset?(name, options)

      self.class.send(:define_method, name) do
        lookup_value(name) || default_value
      end
    end

    private

    def raise_unset(name)
      env_variable_name = name.to_s.upcase
      raise "must set #{env_variable_name}" unless ENV[env_variable_name]
    end

    def guarded_against_unset?(name, options)
      return options[:raise_if_nil] if options.has_key?(:raise_if_nil)
      @raise_if_nil
    end

    def lookup_value(name)
      ENV[name.to_s.upcase] if @use_env
    end
  end
end
