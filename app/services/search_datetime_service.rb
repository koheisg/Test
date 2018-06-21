class SearchDatetimeService

    def initialize(date_param)
        require "date"

        @date_button = date_param

        if @date_button == 'today'
            #現在時刻を取る
            #@now = Time.current
            @now = DateTime.now
            #翌日の5時を取る
            @next_morning = DateTime.now.beginning_of_day + 1.day + 5.hour
        elsif @date_button == 'tomorrow'
            #明日の5時を取る
            #@now = Time.current
            @tomorrow = DateTime.now.beginning_of_day + 1.day + 5.hour
            @next_morning = @tomorrow + 1.day + 5.hour
        elsif @date_button == 'next_sat'
          if Date.today.saturday?
            # 1週間後を取る
            @saturday = DateTime.now.beginning_of_day + 7.day + 5.hour
          else

          end
            @next_morning = @saturday + 1.day + 5.hour
        elsif @date_button == 'next_sun'
          if Date.today.saturday?
            # 1週間後を取る
            @sunday = DateTime.now.beginning_of_day + 7.day + 5.hour
          else
          end
          @next_morning = @sunday + 1.day + 5.hour
        elsif @date_button == 'next_day'
          @next_day = Date.today.next_day.beginning_of_day
          @next_morning = @next_day + 1.day + 5.hour
        elsif @date_button == 'prev_day'
          @prev_day = Date.today.prev_day.beginning_of_day
          @next_morning = @prev_day + 1.day + 5.hour
        end

    end

    def execute
        if @date_button == 'today'
          binding.pry
          # Extract Event data from now until tomorrow 5am / 現在時刻から明日の朝5時までのデータを取得
          return @events = Event.includes(:event_performers, :event_categories, :event_links).where(datetime: @now...@next_morning)
        elsif @date_button == 'tomorrow'
          # Extract Event data on tomorrow (5am to 5am next day) / 明日のデータを取得(朝5時〜翌日朝5時)
          return @events = Event.includes(:event_performers, :event_categories, :event_links).where(datetime: @tomorrow...@next_morning)
        elsif @date_button == 'next_sat'
          return @events = Event.includes(:event_performers, :event_categories, :event_links).where(date: (@saturday)..(@next_morning))
        elsif @date_button == 'next_sun'
          return @events = Event.includes(:event_performers, :event_categories, :event_links).where(date: (@sunday)..(@next_morning))
        elsif @date_button == 'next_day'
            return @events = Event.includes(:event_performers, :event_categories, :event_links).where(date: (@next_day)..(@next_morning))
        elsif @date_button == 'prev_day'
            return @events = Event.includes(:event_performers, :event_categories, :event_links).where(date: (@prev_day)..(@next_morning))
        end

        @events

    end
end