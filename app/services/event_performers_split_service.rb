class EventPerformersSplitService

    def initialize(event_param)
        @event_param = event_param
        @event_performer_param = @event_param[:event_performers_attributes]
        @event_performer_list = @event_performer_param.to_h.values.to_s
    end

    def execute
    	@event_performer_list[] = @event_performer_list.split("\r\n")

    	@event_performer_list.each do |event_performer_list|
		  event_performer_list.each_line do |performer|
		   EventPerformer.new
		   event.event_performer.event_id = @event_param.event_id
		   event.event_performer.performer = performer
		  end
		end

		binding.pry

    	# テキストエリアPerformerに入力された文字列を改行で分割して配列に入れる
    	#array = @event_performer_param
    	#performer = array.split("\r\n")

    	# Performerの数-1分新しいレコードを作る
    	#array.each{|performer|
    	#	EventPerformer.new
    	#	event.event_performer.event_id = @event_param.event_id
    	#	event.event_performer.performer = event_performer.performer
    	#}
    	#binding.pry
    end

end