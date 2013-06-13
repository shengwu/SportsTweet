class CachedResultsController < ApplicationController
  # GET /cached_results
  # GET /cached_results.json
  def index
    @cached_results = CachedResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cached_results }
    end
  end

  # GET /cached_results/1
  # GET /cached_results/1.json
  def show
    @cached_result = CachedResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cached_result }
    end
  end

  # GET /cached_results/name/top_teams
  # GET /cached_results/name/top_teams.json
  def by_name
    @cached_result = CachedResult.where("name = ?", params[:name])[0]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cached_result.result }
    end
  end

  # GET /cached_results/new
  # GET /cached_results/new.json
  def new
    @cached_result = CachedResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cached_result }
    end
  end

  # GET /cached_results/1/edit
  def edit
    @cached_result = CachedResult.find(params[:id])
  end

  # POST /cached_results
  # POST /cached_results.json
  def create
    @cached_result = CachedResult.new(params[:cached_result])

    respond_to do |format|
      if @cached_result.save
        format.html { redirect_to @cached_result, notice: 'Cached result was successfully created.' }
        format.json { render json: @cached_result, status: :created, location: @cached_result }
      else
        format.html { render action: "new" }
        format.json { render json: @cached_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cached_results/1
  # PUT /cached_results/1.json
  def update
    @cached_result = CachedResult.find(params[:id])

    respond_to do |format|
      if @cached_result.update_attributes(params[:cached_result])
        format.html { redirect_to @cached_result, notice: 'Cached result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cached_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cached_results/1
  # DELETE /cached_results/1.json
  def destroy
    @cached_result = CachedResult.find(params[:id])
    @cached_result.destroy

    respond_to do |format|
      format.html { redirect_to cached_results_url }
      format.json { head :no_content }
    end
  end
end
