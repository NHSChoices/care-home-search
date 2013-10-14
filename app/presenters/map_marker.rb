class MapMarker
  def initialize(template, result)
    @template = template
    @result = result
  end

  def render
    content_tag :span, class: 'map-marker', data: data do
      link + address
    end
  end

  private

  def data
    {
      latitude: result.latitude,
      longitude: result.longitude
    }
  end

  def link
    link_to result.name, result
  end

  def address
    content_tag(:p) { result.address.lines.join(',') }
  end

  attr_reader :template, :result

  delegate :content_tag, to: :template
  delegate :link_to, to: :template
end
