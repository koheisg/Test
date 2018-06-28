class SearchEventCategoryService

    def initialize(category_param)
        @category = category_param
    end

    def execute
        event = Event.includes(:event_performers, :event_categories, :event_links)
                .references(:event_performers, :event_categories, :event_links)

        # カテゴリが一致する
        @events = event.where(event_categories: { category: "#{Event.escape_like(@category) }" )
        @results = @events, nil
    end
end