class Search
  include Id::Model
  include Id::Form
  extend Validations

  field :postcode

  validates_presence_of :postcode

  def to_key
    [postcode]
  end

  def to_param
    postcode
  end

  def to_partial_path
    'search'
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Search")
  end

  def results
    @results ||= Request.new(postcode).results
  end

end
