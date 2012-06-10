# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, page_subtitle = '')
    content_for(:title) { h(page_title.to_s) }
    content_for(:title_sub) { h(page_subtitle.to_s) }
  end

  def context_menu(&code)
    content_for(:context_menu) { code.call }
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def link_back(url, title)
    bootstrap_link 'link_back', :url => url, :title => title
  end

  def link_new(url, title)
    bootstrap_link 'link_new', :url => url, :title => title
  end

  def link_show(url, title)
    bootstrap_link 'link_show', :url => url, :title => title
  end

  def link_edit(url, title)
    bootstrap_link 'link_edit', :url => url, :title => title
  end

  def link_delete(url, title, confirm='')
    confirm ||= 'Opravdu odstranit?'
    bootstrap_link 'link_delete', :url => url, :title => title, :confirm => confirm
  end

  private
  def bootstrap_link(partial, locals)
    render :partial => 'shared/' + partial, :locals => locals
  end
end
