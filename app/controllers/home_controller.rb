class HomeController < ApplicationController
  def index
    if ENV.has_key?("FAYE_SERVER")
      @faye_server = ENV['FAYE_SERVER']
    else
      @faye_server = "http://sportstweet-faye.herokuapp.com/faye"
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
