module MapHelper

  def list_map_toggle(search, params)
    ListMapToggle.new(self, search, params).render
  end

  def map_marker(result)
    MapMarker.new(self, result).render
  end

end
