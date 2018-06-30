class SearchEventCategoryService

    def initialize(category_param)
        @category = category_param
    end

    def execute
        # カテゴリが一致する
        @events = Event.display_after_today.ordered_by_datetime.including_event_info.where(event_categories: { category: "#{Event.escape_like(@category) }" )
        @results = @events, nil
    end
end