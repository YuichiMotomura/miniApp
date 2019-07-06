class TweetsController < ApplicationController

  # before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = tweet_params
    Tweet.create(text: tweet[:text], image: tweet[:image], steps: tweet[:steps], user_id: tweet[:user_id])
    redirect_to action: :index
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, :image, :steps).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
