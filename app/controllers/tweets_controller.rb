class TweetsController < ApplicationController
  # binding.pry
  before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
    redirect_to action: :index
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params) if @tweet.user_id == current_user.id
    redirect_to action: :index
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
    redirect_to action: :index
  end

  private

  def tweet_params
    minutes = params.require(:tweet).permit(:minutes)[:minutes].to_i
    weight = current_user.weight
    params.require(:tweet).permit(:text, :image, :minutes).merge(user_id: current_user.id, calorie: calculate_calorie(weight, minutes))
  end

  def calculate_calorie(weight, minutes)
    calorie = (3 * weight * minutes / 60 * 1.05).floor(0)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
