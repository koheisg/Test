class SearchEventPerformerService

    def initialize(performer_param)
        @performer = performer_param
    end

    def execute
        # 出演者とキーワードが一致する
        @events = Event.display_after_today.ordered_by_datetime.including_event_info.where(event_performers: { performer: "#{Event.escape_like(@performer) }" )
        @results = @events, nil
    end
end