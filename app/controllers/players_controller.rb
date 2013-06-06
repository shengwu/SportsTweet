class PlayersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    @players = Player.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/on_team/Boston%20Celtics
  # GET /players/on_team/Boston%20Celtics.json
  # Return a list of players and no. of times each is mentioned
  def on_team
    tweets = Tweet.select("text").map{|tweet| tweet.text}
    players = Player.where("team_name = ?", params[:team_name]).select("name").map{|player| player.name}
    counts = Hash[*players.zip([0]*players.length).flatten]

    tweets.each do |tweet|
      players.each do |name, count|
        # Split name into first name and last name
        fragments = name.downcase.split
        first = fragments[0..-2].join(' ')
        last = fragments.last
        full = name.downcase
        #if (tweet.downcase.include? first and tweet.downcase.include? last) or tweet.downcase.include? full
        if (tweet.downcase.include? first and tweet.downcase.include? last) or tweet.downcase.include? full
          counts[name] += 1
        end
      end
    end

    respond_to do |format|
      format.html # on_team.html.erb
      format.json { render json: counts.sort_by{|_key, value|}.reverse[0..7] }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
end
