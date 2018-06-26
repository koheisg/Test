class GeininsController < ApplicationController
 before_action :set_geinin, only: [:show, :update, :edit, :destroy]
  before_action :set_current_user, only: [:index, :show, :update, :edit, :destroy, :schedule]
  before_action :set_remote_ip, only: [:create, :update]

  def new
      # 芸人を登録
        @geinin = Geinin.new

      # メンバー情報を登録
        @Geinin.geinin_members.build

      # タグを登録
        @geinin.geinin_tags.build

      # メンバータグを登録
        @geinin.geinin_members.geinin_member_tags.build

  end

  def create
        # イベント情報を取得
         @geinin = Geinin.new(geinin_params)

        # DB保存→詳細画面へリダイレクト
        if @geinin.save
            redirect_to geinin_path(@geinin.id), notice: 'ありがとうございます！ライブ登録が完了しました！'
        else
            flash.now[:error] = '芸人登録に失敗しました...。お手数ですが最初からやり直してください。'
            render :new
        end
  end

  def index

    @results = Geinin.all

  end

  def show
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
    geinin = geinin.includes(:geinin_members, :geinin_member_tags, :geinin_tags, :followings)
                .references(:geinin_members, :geinin_member_tags, :geinin_tags, :followings)
    event = Event.includes(:event_performers, :event_categories, :event_links)
    			      .references(:event_performers, :event_categories, :event_links)

    #　ユーザーがフォローしている芸人一覧を取得
    @followings = Followings.select("geinin_id").where(user_id: current_user.id)

    # ユーザーがフォローしている芸人の名前を取得
    @geinins = Geinin.select("name").where(id: @followings.geinin_id)

    # ユーザーがフォローしている芸人の名前でライブ情報を検索
    @events = event.where(event_performers: { performer: @geinins.name } )

    @results = @events
  end


  # フォロー一覧の表示
  def following
    geinin = geinin.includes(:geinin_members, :geinin_member_tags, :geinin_tags, :followings)
                .references(:geinin_members, :geinin_member_tags, :geinin_tags, :followings)

    #　ユーザーがフォローしている芸人一覧を取得
    @followings = Followings.select("geinin_id").where(user_id: current_user.id)

    # ユーザーがフォローしている芸人の名前を取得
    @geinins = Geinin.select("name").where(id: @followings.geinin_id)

    @results = @geinins
  end

private
  #ライブ情報
  def geinin_params
      params.require(:geinin)
      .permit(
          :id,
          :name,
          :yomi,
          :office,
          :start_year,
          :twitter_id,
          :instagram_id,
          geinin_members_attributes: [
              :id,
              :geinin_id,
              :url
	          geinin_members_tags_attributes: [
	              :id,
	              :geinin_id,
	              :geinin_member_id,
	              :tag],
              ],
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

  def set_geinin
      @geinin = Geinin.find(id: params[:id])
  end
end
