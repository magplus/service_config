module ServiceConfig
  class Provider
    def initialize(args)
      @raise_if_nil = args[:raise_if_nil]
      @use_env = args[:use_env]
      yield self
    end

    def provides(name, default_value = '')
      guard_against_unset_env(name) if @raise_if_nil

      self.class.send(:define_method, name) do
        lookup_value(name) || default_value
      end
    end

    private

    def guard_against_unset_env(name)
      env_variable_name = name.to_s.upcase

      unless ENV[env_variable_name]
        raise "must set #{env_variable_name}"
      end
    end

    def lookup_value(name)
      ENV[name.to_s.upcase] if @use_env
    end
  end
end
