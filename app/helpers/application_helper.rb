# -*- encoding : utf-8 -*-
module ApplicationHelper

  def bool_name(boolean_value)
    if boolean_value
      return t('label.bool_true')
    else
      return t('label.bool_false')
    end
  end

  def page_link(page)
    title = page.menu_title
    title ||= page.title
    link_to title, page_seo_path(:controller => :pages, :action => :show, :id => page.id, :slug => page.title.parameterize, :format => :html)
  end
end
