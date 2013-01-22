# -*- encoding : utf-8 -*-
module PagesHelper
  def menu_presence(page)
    present_in = []
    present_in << t('page.attr.navbar_short') if page.navbar
    present_in << t('page.attr.menu_short') if page.menu
    return '' unless present_in
    return '(' + present_in.join('/') + ')'
  end
end
