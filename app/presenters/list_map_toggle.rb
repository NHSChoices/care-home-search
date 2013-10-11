class ListMapToggle

  def initialize(template, search, params)
    @template = template
    @search = search
    @params = params
  end

  def render
    content_tag :ul, class: 'results-view-list' do
      list + map
    end
  end

  def list
    content_tag :li do
      map? ? link_to("List", path) : "List"
    end
  end

  def map
    content_tag :li, class: 'last' do
      map? ? "Map" : link_to("Map", path)
    end
  end

  def path
    search_path(search, map: !map? || nil)
  end

  def map?
    params[:map] == 'true'
  end

  private

  delegate :content_tag, :link_to, :search_path, to: :template

  attr_reader :template, :search, :params
end
