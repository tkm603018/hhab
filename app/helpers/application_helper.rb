module ApplicationHelper
  def sort_order(column, title)
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    url =  { sort: column, direction: direction }
    link_to "#{title} #{sort_direction == 'asc' ? '↓' : '↑'}", "?direction=#{direction}&sort=#{column}#items_table", class: "text-primary text-decoration-none sort_header #{css_class}"
  end
end
