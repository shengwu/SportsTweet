require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    @tweet = tweets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tweets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tweet" do
    assert_difference('Tweet.count') do
      post :create, tweet: { created_at: @tweet.created_at, favorite_count: @tweet.favorite_count, from_user_name: @tweet.from_user_name, hashtags: @tweet.hashtags, id_str: @tweet.id_str, media: @tweet.media, place: @tweet.place, retweet_count: @tweet.retweet_count, text: @tweet.text, urls: @tweet.urls, user_mentions: @tweet.user_mentions }
    end

    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should show tweet" do
    get :show, id: @tweet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tweet
    assert_response :success
  end

  test "should update tweet" do
    put :update, id: @tweet, tweet: { created_at: @tweet.created_at, favorite_count: @tweet.favorite_count, from_user_name: @tweet.from_user_name, hashtags: @tweet.hashtags, id_str: @tweet.id_str, media: @tweet.media, place: @tweet.place, retweet_count: @tweet.retweet_count, text: @tweet.text, urls: @tweet.urls, user_mentions: @tweet.user_mentions }
    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should destroy tweet" do
    assert_difference('Tweet.count', -1) do
      delete :destroy, id: @tweet
    end

    assert_redirected_to tweets_path
  end
end
