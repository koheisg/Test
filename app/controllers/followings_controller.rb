 class FollowingsController < ApplicationController
    def create
        geinin = Geinin.find(params[:geinin_id])
        following = current_user.followings.new(geinin_id: geinin.id)
        following.save
        @geinin = Geinin.find(params[:geinin_id])
        @following = current_user.followings.find_by(geinin_id: params[:geinin_id])
    end

    def destroy
        following = current_user.followings.find_by(geinin_id: params[:geinin_id])
        following.destroy
        @geinin = Geinin.find(params[:geinin_id])
        @following = current_user.followings.find_by(geinin_id: params[:geinin_id])
    end

    def index
        #　ユーザーがフォローしている芸人一覧を取得
        @geinins = Geinin.default.where(followings: { user_id: current_user.id } )
    end
    
    private
    # 芸人情報
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
end
