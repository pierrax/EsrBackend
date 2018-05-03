module Paginator

  ONE_PAGE = 1

  def paginator(collection, options={})
    return unless collection && is_paginated?(collection)

    links = []
    pages_from(collection).map do |key, value|
      params = query_parameters(options).merge(page_number: value, page_size: collection.limit_value).to_query
      links << %(<#{options.fetch(:url, request.base_url)}#{request.path}?#{request.query_parameters.except(:page_number, :page_size).to_query}&#{params}>; rel="#{key}")
    end
    headers['Link'] = links.join(', ') unless links.empty?
    headers['Access-Control-Expose-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Link'
  end

  def pages_from(collection)
    {}.tap do |pages|
      pages['self'] = collection.current_page
      return pages if collection.total_pages == ONE_PAGE

      unless collection.current_page == ONE_PAGE
        pages['first'] = ONE_PAGE
        pages['prev']  = collection.current_page - ONE_PAGE
      end

      unless collection.current_page == collection.total_pages
        pages['next'] = collection.current_page + ONE_PAGE
        pages['last'] = collection.total_pages
      end
    end
  end

  def query_parameters(options)
    {}
  end

  def is_paginated?(collection)
    collection.respond_to?(:current_page) && collection.respond_to?(:total_pages) && collection.respond_to?(:size)
  end
end
