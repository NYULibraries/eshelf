module FiltersHelper
  # Returns an Array of 'per page' pagination options as HTML links
  #   - 10
  #   - 20
  #   - 50
  #   - 100
  def per_page_options
    [ link_to(10, records_path(current_filters.merge(per: 10))),
      link_to(20, records_path(current_filters.merge(per: 20))),
      link_to(50, records_path(current_filters.merge(per: 50))),
      link_to(100, records_path(current_filters.merge(per: 100)))]
  end

  # Returns an Array of sort options as HTML links
  #   - Created at
  #   - Title
  #   - Author
  def sort_options
    [ 
      link_to(t('record.collection.sort.options.created_at'), records_path(current_filters.merge(sort: sort_param("created_at"))), class: "sorted#{sort_direction_class("created_at")}"),
      link_to(t('record.collection.sort.options.title_sort'), records_path(current_filters.merge(sort: sort_param("title_sort"))), class: "sorted#{sort_direction_class("title_sort")}"),
      link_to(t('record.collection.sort.options.author'), records_path(current_filters.merge(sort: sort_param("author"))), class: "sorted#{sort_direction_class("author")}")
    ]
  end

  def current_sort_label
    @current_sort_label ||= t("record.collection.sort.options.#{parsed_current_sort.first}").html_safe
  end

  def parsed_current_sort
    @parsed_current_sort ||= (whitelisted_sort_field?(filter_params[:sort])) ? filter_params[:sort].split(/(.+)_(desc|asc)/) - ["", nil] : ["created_at", "desc"]
  end

  def secondary_sort
    case parsed_current_sort.first.to_sym
    when :title_sort
      :created_at
    when :author
      :title_sort
    else
      :created_at
    end
  end

  def filter_params
    params.permit(:page, :content_type, :tag, :external_system, :external_id, :sort, :per, :format, :_, :institution, :id, id: [])
  end

 protected

  def sort_param(sort_field)
    sort_param = "#{sort_field}_"
    current_sort_field = parsed_current_sort.first
    current_sort_direction = parsed_current_sort.last
    if sort_field == current_sort_field
      sort_param += switch_sort_direction(current_sort_direction)
    else
      sort_param += "asc"
    end
    sort_param
  end

  def sort_direction_class(sort_field)
    if sort_field == parsed_current_sort.first
      " #{parsed_current_sort.last}"
    end
  end

  def switch_sort_direction(direction)
    (direction == "asc") ? "desc" : "asc"
  end

  def whitelisted_sort_field?(sort_field)
    /^(created_at|title_sort|author)_(asc|desc)$/.match?(sort_field)
  end

  # Returns a Hash of the currently applied filters
  #   - content type
  #   - tag
  #   - id
  #   - external_system
  #   - external_id
  #   - sort
  #   - page
  #   - per
  def current_filters
    { content_type: filter_params[:content_type], tag: filter_params[:tag], id: filter_params[:id],
      external_system: filter_params[:external_system], external_id: filter_params[:external_id],
      sort: filter_params[:sort], page: filter_params[:page], per: filter_params[:per] }
  end

end