class SearchKeywordService

    def initialize(keyword_param)
        @keyword = keyword_param
    end

    def execute
        event = Event.includes(:event_performers, :event_categories, :event_links)
                .references(:event_performers, :event_categories, :event_links)

        # タイトルもしくは説明にキーワードが含まれる
        @events = event.where("(title LIKE(?)) OR (description LIKE (?)
        )", "%#{Event.escape_like(@keyword)}%" , "%#{Event.escape_like(@keyword)}%")

        # 出演者にキーワードが含まれる
        if event.where('event_performers.performer like ?', "%#{Event.escape_like(@keyword)}%").exists?
		      @events = @events + event.where('event_performers.performer like ?', "%#{Event.escape_like(@keyword)}%")
		    end

        @results = @events, nil
    end
end