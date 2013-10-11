class Search
  module Validations
    delegate :validates_presence_of, to: :form_object
  end
end
