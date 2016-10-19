module ApplicationHelper
  def active_anchor(link_path)
    current_page?(link_path) ? 'active' : ''
  end
end
