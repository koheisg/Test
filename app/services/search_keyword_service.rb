class SearchKeywordService

    def initialize(keyword_param)
        @keyword = keyword_param
    end

    def execute
        @events = Event.includes(:event_performers, :event_categories, :event_links).where("(title LIKE(?)) OR (description LIKE (?)
        )", "%#{@keyword}%" , "%#{@keyword}%")

        if Event.includes(:event_performers, :event_categories, :event_links).where(event_performers: { performer: @keyword } ).present?
		  #Event.includes(:event_performers, :event_categories, :event_links).where(event_performers.arel_table[:performer].matches("%#{@keyword}%"))
		  @events = @events + Event.includes(:event_performers, :event_categories, :event_links).where(event_performers: { performer: @keyword } )
		end

        @events
    end
end