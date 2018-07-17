class SearchDatetimeService

  def initialize(date_param,datetime_param)
    require "date"

    # 検索したい日付
    @date = date_param

    # 今見てるページの日付
    @datetime = datetime_param

    # 今日の始まり
    @today = DateTime.now.beginning_of_day

    case @date
    when 'today' then
      #翌日の5時を取る
      @next_morning = @today + 1.day + 5.hour
    when 'tomorrow' then
      @tomorrow = @today + 1.day + 5.hour
      @next_morning = @tomorrow + 1.day + 5.hour
    when 'next_sat' then
      if Date.today.saturday?
        # 1週間後を取る
        @next_sat = @today + 7.day + 5.hour
      else
        @day = DateTime.now.wday
        @next_sat = @today + (6-@day).day + 5.hour
      end
        @next_morning =  0.days.ago.next_week(:saturday)
    when 'next_sun' then
      if Date.today.sunday?
        # 1週間後を取る
        @next_sun = @today + 7.day + 5.hour
      else
        @day = DateTime.now.wday
        @next_sun = 0.days.ago.next_week(:sunday)
      end
      @next_morning = @next_sun + 1.day + 5.hour
    when 'next_day' then
      @datetime = DateTime.parse(@datetime)
      @next_day = @datetime.next_day.beginning_of_day
      @next_morning = @next_day + 1.day + 5.hour
    when 'prev_day' then
      @datetime = DateTime.parse(@datetime)
      @prev_day = @datetime.prev_day.beginning_of_day
      @next_morning = @prev_day + 1.day + 5.hour
    else
      @next_morning = @date.beginning_of_day + 1.day + 5.hour
    end

  end

  def execute
    case @date
    when 'today' then
      # Extract Event data from now until tomorrow 5am / 現在時刻から明日の朝5時までのデータを取得
      @from = DateTime.now
      @datetime = @today
    when 'tomorrow' then
      # Extract Event data on tomorrow (5am to 5am next day) / 明日のデータを取得(朝5時〜翌日朝5時)
      @from = @tomorrow
      @datetime = @tomorrow
    when 'next_sat' then
      @from = @next_sat
      @datetime = @next_sat
    when 'next_sun' then
      @from = @next_sun
      @datetime = @next_sun
    when 'next_day' then
      @from = @next_day
      @datetime = @next_day
    when 'prev_day' then
      @from = @prev_day
      @datetime = @prev_day
    else
      @from = @date
      @datetime = @date
    end

    @to = @next_morning
    @events = Event.datetime_search(@from,@to)
    return @results = @events, @datetime,nil

  end
end