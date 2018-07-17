class SearchKeywordService

    def initialize(keyword_param)
        @keyword = keyword_param
    end

    def execute
        #event = Event.display_after_today.ordered_by_datetime.including_event_info

        # タイトルもしくは説明にキーワードが含まれる
        @events = Event.default.where("(title LIKE(?)) OR (description LIKE (?)
        )", "%#{Event.escape_like(@keyword)}%" , "%#{Event.escape_like(@keyword)}%")

        # 出演者にキーワードが含まれる
        if Event.default.where('event_performers.performer like ?', "%#{Event.escape_like(@keyword)}%").exists?
		      @events = @events + event.where('event_performers.performer like ?', "%#{Event.escape_like(@keyword)}%")
		    end

        @results = @events, nil
    end
end