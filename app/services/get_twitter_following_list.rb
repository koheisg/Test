class GetTwitterFollowingList

    def initialize(twitter_id,user_id)
        @twitter_id = twitter_id
        @user_id = user_id
    end

    def execute        
      require 'twitter'

      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
        config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
      end

      # フォローしてるユーザーのid一覧を取得
      following_ids = client.friend_ids(@twitter_id)

      # フォローしてるユーザーのnickname一覧を取得
      begin
        followings = following_ids.each_slice(100).to_a.inject ([]) do |users, ids|
          users.concat(client.users(ids))
        end

      #followings.each_with_index{ |user, i| puts "#{i + 1}: #{user.screen_name}" }
      
      @followings_list = []

      followings.each do |user| 
        @followings_list << "#{user.screen_name}" 
      end

      # 取得したIDで芸人テーブルを検索
      @geinins = Geinin.default.where(twitter_id: @followings_list )
      
      # 取得したIDと合致した芸人をフォローする
      if @geinins.exists?
        @geinins.each do |geinin|
          GeininFollowings.create(geinin_id: geinin.geinin_id, user_id: @user_id)
        end
      end

      rescue Twitter::Error::TooManyRequests => error
       sleep error.rate_limit.reset_in
      retry
      end

    end
end