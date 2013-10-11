module Id
  class FormBuilder < ActionView::Helpers::FormBuilder

    def initialize(object_name, object, template, options)
      object = object.respond_to?(:to_model) ? object.to_model : object
      super object_name, object, template, options
    end

  end
end
