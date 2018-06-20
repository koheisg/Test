  links = []
  month = 1

  #1月〜12月分のURLを取得
  while month <= 12 do
    if month <= 9
      links << ("http://www.yoshimoto.co.jp/lumine/schedule0"+ "#{month}"+".php")
    else
      links << ("http://www.yoshimoto.co.jp/lumine/schedule"+"#{month}"+".php")
    end
    month = month + 1
  end

  links.each do |lumine_url|
      get_lumine(lumine_url)
  end

  #ルミネのページをスクレイピング
  #　インスタンスを作成、HTML情報を取得
  lumine = Mechanize.new
  page = lumine.get(lumine_url)

  # 取ってきたHTML情報のうち、対応するCSSの部分のみ抜き出し
  schedule_part = page.search('#schedule_pc')
  eles = schedule_part.search('ul')
  eles.each do |ele|
    if ele.search('#dayTitle').present?
      day = ele.search('#dayTitle').inner_text
    else
      day = Event.last.day
    end
    title = ele.search('li .schedule_con, .lastChild')[1].inner_text
    details = ele.search('li .schedule_con, .lastChild')[0].inner_text
    place = '\nルミネtheよしもと\n'
    price = ele.search('li .schedule_con, .lastChild')[4].inner_text
    performers_list = ele.search('li .schedule_con, .lastChild')[2].inner_text
    detail = ele.search('li .schedule_con, .lastChild')[3].inner_text

    description = details+"\n"+place+price+"¥n"+performers_list+details

    binding.pry

    p title
    p description

    event = Event.where(title: title, datetime: day, starting_time: starting_time, remarks: remarks).first_or_create

    performers = performers_list.gsub(/\r\n|\s/,"").gsub(/\[.*?\]/,"／").split("／").reject(&:blank?)
    performers.each do |name|
      performer = Performer.where(name: name).first_or_create
      event.performers << performer
    end
  end