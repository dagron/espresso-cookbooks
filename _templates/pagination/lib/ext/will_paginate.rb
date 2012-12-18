### copy from will_paginate/sinatra + adjustments for bootstrap css pagination (https://gist.github.com/1205828)
require 'will_paginate/view_helpers'
require 'will_paginate/view_helpers/link_renderer'
module WillPaginate
  module E
    module Helpers
      include ViewHelpers

      def page_navigation_links(pages)
        will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;', :next_label => '&rarr;')
      end

      def will_paginate(collection, options = {}) #:nodoc:
        options = options.merge(:renderer => LinkRenderer) unless options[:renderer]
        super(collection, options)
      end
    end

    class LinkRenderer < ViewHelpers::LinkRenderer
      protected

      def url(page)
        str = File.join(request.script_name.to_s, request.path_info)
        params = request.GET.merge(param_name.to_s => page.to_s)
        params.update @options[:params] if @options[:params]
        str << '?' << build_query(params)
      end

      def request
        @template.request
      end

      def build_query(params)
        Rack::Utils.build_nested_query params
      end
    end


    class BootstrapLinkRenderer < ::WillPaginate::E::LinkRenderer
      protected

      def html_container(html)
        tag :div, tag(:ul, html), container_attributes
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
      end

      def gap
        tag :li, link(super, '#'), :class => 'disabled'
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end
    end
  end
end