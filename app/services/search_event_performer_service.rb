class SearchEventPerformerService

    def initialize(performer_param)
        @performer = performer_param
    end

    def execute
        # 出演者とキーワードが一致する
        @events = Event.default.where(event_performers: { performer: "#{Event.escape_like(@performer) }" )
        @results = @events, nil
    end
end