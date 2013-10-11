module ApplicationHelper

  def page_title
    I18n.t params[:action], scope: [:title, params[:controller]]
  end

end
