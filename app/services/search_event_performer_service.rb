class SearchEventPerformerService

    def initialize(performer_param)
        @performer = performer_param
    end

    def execute
        event = Event.includes(:event_performers, :event_categories, :event_links)
                .references(:event_performers, :event_categories, :event_links)

        # 出演者とキーワードが一致する
        @events = event.where(event_performers: { performer: "#{Event.escape_like(@performer) }" )
        @results = @events, nil
    end
end