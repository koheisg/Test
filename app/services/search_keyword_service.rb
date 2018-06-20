class SearchKeywordService

    def initialize(keyword_param)
        @keyword = keyword_param
    end

    def execute
        @events = Event.where("(title = ?) OR (description = ?)", @keyword, @keyword)
        binding.pry
        #@events_2 = Event.eager_load(:event_performers).where(event_performers: { performer: @keyword })
        #@events = @events.merge(@events_2)

        @events
    end
end