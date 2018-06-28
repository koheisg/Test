class SearchDatetimeService

  def initialize(date_param,datetime_param)
    require "date"

    # 検索したい日付
    @date = date_param

    # 今見てるページの日付
    @datetime = datetime_param

    # 今日の始まり
    @today = DateTime.now.beginning_of_day

    if @date == 'today'
      #翌日の5時を取る
      @next_morning = @today + 1.day + 5.hour
    elsif @date == 'tomorrow'
      @tomorrow = @today + 1.day + 5.hour
      @next_morning = @tomorrow + 1.day + 5.hour
    elsif @date == 'next_sat'
      if Date.today.saturday?
        # 1週間後を取る
        @next_sat = @today + 7.day + 5.hour
      else
        @day = DateTime.now.wday
        @next_sat = @today + (6-@day).day + 5.hour
      end
        @next_morning = @next_sat + 1.day + 5.hour
    elsif @date == 'next_sun'
      if Date.today.sunday?
        # 1週間後を取る
        @next_sun = @today + 7.day + 5.hour
      else
        @day = DateTime.now.wday
        @next_sun = @today + (7-@day).day + 5.hour
      end
      @next_morning = @next_sun + 1.day + 5.hour
    elsif @date == 'next_day'
      @datetime = DateTime.parse(@datetime)
      @next_day = @datetime.next_day.beginning_of_day
      @next_morning = @next_day + 1.day + 5.hour
    elsif @date == 'prev_day'
      @datetime = DateTime.parse(@datetime)
      @prev_day = @datetime.prev_day.beginning_of_day
      @next_morning = @prev_day + 1.day + 5.hour
    else
      @next_morning = @date.beginning_of_day + 1.day + 5.hour
    end

  end

  def execute
    if @date == 'today'
      # Extract Event data from now until tomorrow 5am / 現在時刻から明日の朝5時までのデータを取得
      @events = event.where(datetime: DateTime.now...@next_morning),
      @datetime = @today
    elsif @date == 'tomorrow'
      # Extract Event data on tomorrow (5am to 5am next day) / 明日のデータを取得(朝5時〜翌日朝5時)
      @events = event.where(datetime: @tomorrow...@next_morning)
      @datetime = @tomorrow
    elsif @date == 'next_sat'
      @events = event.where(datetime: (@next_sat)..(@next_morning))
      @datetime = @next_sat
    elsif @date == 'next_sun'
      @events = event.where(datetime: (@next_sun)..(@next_morning))
      @datetime = @next_sun
    elsif @date == 'next_day'
      @events = event.where(datetime: (@next_day)..(@next_morning))
      @datetime = @next_day
    elsif @date == 'prev_day'
      @events = event.where(datetime: (@prev_day)..(@next_morning))
      @datetime = @prev_day
    else
      @events = event.where(datetime: (@date)..(@next_morning))
      @datetime = @date
    end

    return @results = @events, @datetime

  end
end