class SearchKeywordService

    def initialize(keyword_param)
        @keyword = keyword_param
    end

    def execute
        
        # タイトルもしくは説明にキーワードが含まれる
        @events = Event.default.where("(title LIKE(?)) OR (description LIKE (?)
        )", "%#{Event.escape_like(@keyword)}%" , "%#{Event.escape_like(@keyword)}%")

        # 出演者にキーワードが含まれる
        if Event.default.where('event_performers.performer like ?', "%#{Event.escape_like(@keyword)}%").exists?
		    @events = @events + Event.default.where('event_performers.performer like ?', "%#{Event.escape_like(@keyword)}%")
		end

        @results = @events, nil
    end
end