class GeininsController < ApplicationController
  before_action :set_geinin, only: [:show, :update, :edit, :destroy]
  before_action :set_current_user, only: [:index, :show, :update, :edit, :destroy, :schedule,:following]
  before_action :set_remote_ip, only: [:create, :update]

  def new
      # 芸人を登録
        @geinin = Geinin.new

      # メンバー情報を登録
        @geinin.geinin_members.build

      # タグを登録
        @geinin.geinin_tags.build

      # メンバータグを登録
       # Geinin_members.geinin_members_tags.build
       # geinin_members_tags = GeininMembers.GeininMembersTags.new
       # geinin_members_tags.save
  end

  def create
        # イベント情報を取得
         @geinin = Geinin.new(geinin_params)

        # DB保存→詳細画面へリダイレクト
        if @geinin.save
            redirect_to geinin_path(@geinin.id), notice: 'ありがとうございます！芸人wiki登録が完了しました！'
        else
            flash.now[:error] = '芸人wiki登録に失敗しました...。お手数ですが最初からやり直してください。'
            render :new
        end
  end

  def index

    @geinins = Geinin.default.all
    @geinin_tags = GeininTag.order("RANDOM()").limit(10)

  end

  def show
		# 出演者とキーワードが一致する
		@events = Event.default.where(event_performers: { performer: "#{Event.escape_like(@geinin.name)}"} )
  end

  def edit

  end

  def update
      # エラーチェック＆DB保存→詳細画面へリダイレクト
      if @geinin.update(geinin_params)
          # イベントが編集されたら、変更履歴テーブルを更新
          @geinin_id = @geinin.id
          redirect_to geinin_path(params[:id]) , notice: 'ありがとうございます！芸人wikiの編集が完了しました！'
      else
          flash.now[:error] = '芸人wikiの編集に失敗しました。お手数ですが最初からやり直してください。'
          render :edit
      end
  end

  def destroy
      @geinin.destroy
      redirect_to geinins_path
  end

  # 芸人スケジュールの表示
  def schedule
    #　ユーザーがフォローしている芸人一覧を取得
    @geinins = Geinin.default.where(followings: { user_id: @user_id } )

    # ユーザーがフォローしている芸人の名前でライブ情報を検索
    @events_followings = Event.default.where(event_performers: { performer: @geinins.name } )

  end

  private
    #ライブ情報
    def geinin_params
        params.require(:geinin)
        .permit(
            :id,
            :name,
            :yomi,
            :agency,
            :office,
            :start_year,
            :twitter_id,
            :instagram_id,
            :youtube_url,
            :blog_url,
            geinin_members_attributes: [
                :id,
                :geinin_id,
                :url],
                #   geinin_members_tags_attributes: [
                #       :id,
                #       :geinin_id,
                #       :geinin_member_id,
                #       :tag],
                #   ],
            geinin_tags_attributes: [
                :id,
                :geinin_id,
                :tag],
        )
    end

    #ユーザー情報
    def user_params
        params.require(:user).permit(:id, :name, :profile_image, :uid, :email, :password)
    end

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
          :place,
          :general_sale,
          :presale_start,
          :presale_end,
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
			
    def set_current_user
        if current_user.present?
            @user = current_user
            # ログインユーザーを取得
            @user_id = current_user.id
        end
    end

    def set_geinin
        @geinin = Geinin.find(params[:id])
    end
end