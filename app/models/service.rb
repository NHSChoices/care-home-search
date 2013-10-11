class Service
  include Id::Model

  field :id
  field :name
  field :type
  field :longitude
  field :latitude
  field :distance
  field :summary_html,           key: 'summaryText'
  field :website,                key: 'WebAddress',       optional: true
  field :things_you_should_know, key: 'thingsShouldKnow', optional: true

  has_one :address, type: Address
  has_one :contact, type: Contact, optional: true

  def summary
    CGI.unescapeHTML(summary_html)
  end

end
