class Provider
  include Id::Model

  field :id
  field :type
  field :longitude
  field :latitude
  field :distance
  field :name,         key: 'deliverer',    default: "No data available"
  field :summary_html, key: 'summaryText',  optional: true
  field :phone,        key: 'phone',        optional: true
  field :fax,          key: 'fax',          optional: true
  field :website,      key: 'website',      optional: true

  has_one :address,    type: Address
  has_one :coordinate, type: Coordinate, key: 'geographicCoordinates'

  def summary
    summary_html.map(&CGI.method(:unescapeHTML))
  end

  def to_param
    id
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Provider")
  end

end
