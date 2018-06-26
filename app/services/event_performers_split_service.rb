class EventPerformersSplitService

    def initialize(event_performer_param,event_id)
        @event_id = event_id
        @event_performer_param = event_performer_param
        @event_performer = @event_performer_param.to_h['0']["performer"]
    end

    def execute
    	@event_performer_list = @event_performer.split("\r\n")

		  @event_performer_list.each do |performer|
		   EventPerformer.create(event_id: @event_id,performer: performer)
		   binding.pry
		  end
    end
end

private
  #ライブ情報
  def event_params
      params.require(:event)
      .permit(
          :id,
          :datetime,
          :title,
          :description,
          :tel,
          :email,
          :image,
          event_links_attributes: [
              :id,
              :event_id,
              :url],
          event_change_histories_attributes: [
              :id,
              :event_id,
              :user_id,
              :user_ip],
          event_performers_attributes: [
              :id,
              :event_id,
              :performer],
          event_categories_attributes: [
              :id,
              :event_id,
              :category]
      )
  end