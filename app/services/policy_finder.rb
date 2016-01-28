class PolicyFinder
  SUFFIX = 'Policy'

  attr_reader :object, :namespace

  def initialize(object)
    @object = object
  end

  def policy
    klass = if object.respond_to?(:model_name)
      object.model_name.to_s
    elsif object.is_a?(Symbol)
      object.to_s.camelize
    else
      object.class
    end

    "#{klass}#{SUFFIX}".constantize
  end
end
