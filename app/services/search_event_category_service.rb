class SearchEventCategoryService

    def initialize(category_param)
        @category = category_param
    end

    def execute
        # カテゴリが一致する
        @events = Event.default.where(event_categories: { category: "#{Event.escape_like(@category)}"} ) 
        @results = @events, nil,@category
    end
end