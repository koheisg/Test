class GetTwitterFollowingList

    def initialize(twitter_id)
        @twitter_id = twitter_id
    end

    def execute        
      require 'twitter'

      # Twitter = Twitter::REST::Client.new do |config|
      #   config.consumer_key        = ENV["TWITTER_API_KEY"]
      #   config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      #   config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
      #   config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
      # end

      Twitter.configure do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
        config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
      end

      #my_user = twitter.user

      #フォロー数を取得する
      @following_count = @twitter_id.friends_count

      #フォローしているユーザーのID一覧を取得する
      @following_list = client.friend_ids(@twitter_id).take(@following_count)

    end
end