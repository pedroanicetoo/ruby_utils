require 'observer'

# example extracted: https://stackoverflow.com/a/3638771/21480599

module SuperSimpleCallbacks
  include Observable

  def self.included(klass)
    klass.extend ClassMethods
    klass.initialize_included_features
  end

  # the observed is made also observer
  def initialize
    add_observer(self)
  end

  # TODO: dry
  def update(method_name, callback_type) # hook for the observer
    case callback_type
    when :before then self.class.callbacks[:before][method_name.to_sym].each{|callback| send callback}
    when :after then self.class.callbacks[:after][method_name.to_sym].each{|callback| send callback}
    end
  end

  module ClassMethods
    def initialize_included_features
      @callbacks = Hash.new
      @callbacks[:before] = Hash.new{|h,k| h[k] = []}
      @callbacks[:after] = @callbacks[:before].clone
      class << self
        attr_accessor :callbacks
      end
    end

    def method_added(method)
      redefine_method(method) if is_a_callback?(method)
    end

    def is_a_callback?(method)
      registered_methods.include?(method)
    end

    def registered_methods
      callbacks.values.map(&:keys).flatten.uniq
    end

    def store_callbacks(type, method_name, *callback_methods)
      callbacks[type.to_sym][method_name.to_sym] += callback_methods.flatten.map(&:to_sym)
    end

    def before(original_method, *callbacks)
      store_callbacks(:before, original_method, *callbacks)
    end

    def after(original_method, *callbacks)
      store_callbacks(:after, original_method, *callbacks)
    end

    def objectify_and_remove_method(method)
      if method_defined?(method.to_sym)
        original = instance_method(method.to_sym)
        remove_method(method.to_sym)
        original
      else
        nil
      end
    end

    def redefine_method(original_method)
      original = objectify_and_remove_method(original_method)
      mod = Module.new
      mod.class_eval do
        define_method(original_method.to_sym) do
          changed; notify_observers(original_method, :before)
          original.bind(self).call if original
          changed; notify_observers(original_method, :after)
        end
      end
      include mod
    end
  end
end
